//
//  ALMagicShowCell.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicShowCell.h"
#import "UIKit+AFNetworking.h"
#import "NSDateUtilities.h"
@implementation ALMagicShowCell{
    ALLabel *lbl;
    ALLabel *subLbl;
    UIView *theContentView;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        lbl=[[ALLabel alloc]
             initWithFrame:CGRectMake(0, 0, leftWidth, 15)
             andColor:colorByStr(@"#75491F")
             andFontNum:15];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self addSubview:lbl];
        
        subLbl=[[ALLabel alloc]
                initWithFrame:CGRectMake(0,
                                         lbl.bottom,
                                         leftWidth,
                                         lbl.height)
                andColor:colorByStr(@"#75491F")
                andFontNum:10];
        [subLbl setTextAlignment:NSTextAlignmentRight];
        [self addSubview:subLbl];
        
        theContentView=[[UIView alloc]
                                initWithFrame:CGRectMake(leftWidth,
                                                         0,
                                                         self.width-leftWidth,
                                                         self.height)];
        [theContentView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:theContentView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];

    [lbl setFrame:CGRectMake(0, 0, leftWidth - 5, 15)];
    [subLbl setFrame:CGRectMake(0, lbl.bottom, leftWidth - 5, lbl.height)];
    [theContentView setFrame:CGRectMake(leftWidth, 0, self.width-leftWidth, self.contentView.size.height)];
}
-(void)setModel:(ALMagicShowModel *)theModel{
    NSDate *theDate= [NSDate dateWithTimeIntervalString:theModel.createTime];
    
    NSArray *imgArr=[[theModel imageurls] componentsSeparatedByString:@";"];
    
    [lbl setText:[NSString stringWithFormat:@"%ld.%ld",(long)[theDate month],(long)[theDate day]]];
    [subLbl setText:[NSString stringWithFormat:@"%ld",(long)[theDate year]]];
    
    [theContentView removeAllSubviews];
    
    [imgArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if (imgArr.count-1==idx) {
//            return;
//        }
        if (![obj length]>0) {
            return;
        }
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectMake(0,
                                                       0,
                                                       200/4,
                                                       200/4)];
        [imgView setImageWithURL:[NSURL URLWithString:obj]
                placeholderImage:[UIImage imageNamed:@"icon"]];
        [imgView setUserInteractionEnabled:YES];
        [imgView setTag:idx+10000];
        [theContentView addSubview:imgView];
//        theContentView.backgroundColor = [UIColor redColor];
        
        if (idx/4==0) {
            [imgView setFrame:CGRectMake(idx*(200/4+5/2) + 10, 0, 50, 50)];
        }else if (idx/4==1){
            [imgView setFrame:CGRectMake((idx-4*1)*(200/4+5/2)+ 10, 200/4*1+5/2, 50, 50)];
        }else if (idx/4==2){
            [imgView setFrame:CGRectMake((idx-8*1)*(200/4+5/2)+ 10, 200/4*2+5/2 * 2, 50, 50)];
        }else if (idx/4==3){
            [imgView setFrame:CGRectMake((idx-12*1)*(200/4+5/2)+ 10, 200/4*3+5/2 * 3, 50, 50)];
        }else{
        }
        
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgView:)];
        tap.delegate = self;
        [imgView addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
        [longPress addTarget:self action:@selector(longPressImgView:)];
        // 至少长按2秒
        longPress.minimumPressDuration = 0.8;
        // 在触发手势之前,50px范围内长按有效
//        longPress.allowableMovement = 50;
        [imgView addGestureRecognizer:longPress];
    }];
}
-(void)tapImgView:(UIGestureRecognizer *)sender{
    ALImageView *theImgView=(ALImageView *)[sender view];
    if (self.theBlock) {
        self.theBlock(MSTapClick_type,theImgView.tag-10000);
    }
}
-(void)longPressImgView:(UIGestureRecognizer *)sender{
    ALImageView *theImgView=(ALImageView *)[sender view];
    if (self.theBlock) {
        self.theBlock(MSLongTapClick_type,theImgView.tag-10000);
    }
}
@end
