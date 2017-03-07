//
//  OcnTableViewCell.m
//  testCell
//
//  Created by OCN on 15-1-22.
//  Copyright (c) 2015年 OCN. All rights reserved.
//

#import "OcnTableViewCell.h"

@implementation OcnTableViewCell{
    float startX;
    UIView *contextMenuView;
    NSArray *_imgArr;
    NSArray *_titArr;
    float btnTotalWidth;
    CGPoint startPoint;
    CGPoint midPoint;
    CGPoint endPoint;
    NSMutableArray *_btnArr;
    BOOL isDel;
    BOOL _isHua;
    
    UITapGestureRecognizer *tapGes;
}
-(void)setImages:(NSArray *)imgArr
          orTits:(NSArray *)titArr
         andBack:(void(^)(NSInteger index))theBack{
    _imgArr=imgArr;
    _titArr=titArr;
    
    if (_imgArr.count>0) {
        [_imgArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(self.width-(idx+1)*70, 0, 70, self.height)];
            [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
            [btn setBackgroundColor:isDel?[UIColor redColor]:[UIColor lightGrayColor]];
            [btn setTheBtnClickBlock:^(id sender){
                if (theBack) {
                    theBack(idx);
                }
            }];
            [contextMenuView addSubview:btn];
            [_btnArr addObject:btn];
            isDel=!isDel;
        }];
        btnTotalWidth=70*_imgArr.count;
    }
    else{
        [_titArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *btn=[ALButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(self.width-(idx+1)*70, 0, 70, self.height)];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setBackgroundColor:isDel?[UIColor redColor]:[UIColor lightGrayColor]];
            [btn setTheBtnClickBlock:^(id sender){
                if (theBack) {
                    theBack(idx);
                }
            }];
            [contextMenuView addSubview:btn];
            [_btnArr addObject:btn];
            isDel=!isDel;
        }];
        btnTotalWidth=70*_titArr.count;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isHua=NO;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
          andCanHua:(BOOL)isHua
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isHua=isHua;
        if (_isHua) {
            _btnArr=[[NSMutableArray alloc] initWithCapacity:2];
            isDel=YES;
            [self upLoad];
        }
    }
    return self;
}

-(void)upLoad{
    self.actualContentView=[[UIView alloc]
                            initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.actualContentView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.actualContentView];
    
    contextMenuView = [[UIView alloc]
                            initWithFrame:self.actualContentView.bounds];
    contextMenuView.backgroundColor = self.contentView.backgroundColor;
    [self.contentView insertSubview:contextMenuView belowSubview:self.actualContentView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(handlePan:)];
    panRecognizer.delegate = self;
    [self.actualContentView addGestureRecognizer:panRecognizer];
    
    tapGes = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:@selector(handelTap:)];
    [tapGes setNumberOfTouchesRequired:1];//触摸点个数
    
}
-(void)handelTap:(UIPanGestureRecognizer *)recognizer{
    CGPoint startPoint=CGPointMake(320/2.0, self.frame.size.height/2.0f);
    
    [UIView animateWithDuration:.3f animations:^{
        [self.actualContentView setCenter:startPoint];
    } completion:^(BOOL finished) {
        [self.actualContentView removeGestureRecognizer:tapGes];
    }];
}
-(void)handlePan:(UIPanGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint currentTouchPoint = [recognizer locationInView:self.contentView];
        startX=currentTouchPoint.x;
        
         startPoint=CGPointMake(self.actualContentView.width/2.0f, self.height/2.0f);
         midPoint=CGPointMake(self.actualContentView.width/2.0f-btnTotalWidth/2.0f, self.height/2.0f);
         endPoint=CGPointMake(self.actualContentView.width/2.0f-btnTotalWidth, self.height/2.0f);
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentTouchPoint = [recognizer locationInView:self.contentView];
        
        //间距  结束-开始
        float rectX=currentTouchPoint.x-startX;
        NSLog(@"startX=%f",startX);
        NSLog(@"rectX=%f",rectX);
        startX=currentTouchPoint.x;
        CGPoint curRect=CGPointMake(rectX+self.actualContentView.center.x, self.frame.size.height/2.0f);
        
        if (curRect.x>endPoint.x) {
            [self.actualContentView setCenter:curRect];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (self.actualContentView.center.x<midPoint.x) {
            [UIView animateWithDuration:.3f animations:^{
                [self.actualContentView setCenter:endPoint];
            } completion:^(BOOL finished) {
                [self.actualContentView addGestureRecognizer:tapGes];
            }];
        }
        else{
            [UIView animateWithDuration:.3f animations:^{
                [self.actualContentView setCenter:startPoint];
            } completion:^(BOOL finished) {
                [self.actualContentView removeGestureRecognizer:tapGes];
            }];
        }
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_isHua) {
        [self.actualContentView setFrame:CGRectMake(self.actualContentView.frame.origin.x, self.actualContentView.frame.origin.y, self.actualContentView.frame.size.width, self.frame.size.height)];
        [contextMenuView setFrame:self.actualContentView.bounds];
        
        [_btnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton *theBtn=_btnArr[idx];
            [theBtn setHeight:contextMenuView.height];
        }];
    }
}

@end
