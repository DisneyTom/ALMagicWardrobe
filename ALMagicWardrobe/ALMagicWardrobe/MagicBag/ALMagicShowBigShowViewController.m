//
//  ALMagicShowBigShowViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-11.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicShowBigShowViewController.h"
//#import "AFNconnectionImport.h"
@interface ALMagicShowBigShowViewController ()
<UIScrollViewDelegate>
@end

@implementation ALMagicShowBigShowViewController{
    NSInteger theCurIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"魔镜秀";
//    __block ALMagicShowBigShowViewController *theBlockCtrl=self;
    
    [self _initData];
    
    [self _initView];
    
//    [self setViewWithType:rightBtn1_type
//                  andView:^(id view) {
//                      [AFNconnectionImport connectionWifi];
//                      ALButton *theBtn=view;
//                      [theBtn setTitle:@"分享" forState:UIControlStateNormal];
//                  } andBackEvent:^(id sender) {
//                      NSArray *arr= [theBlockCtrl.theModel.imageurls componentsSeparatedByString:@";"];
//                      NSString *imgUrl=arr[theCurIndex];
//                      NSString *str=@"今天的我长这样";
//                      [theBlockCtrl showShare:YES andClick:^(NSInteger index) {
//                          if (index==0) { //微信好友
//                              [theBlockCtrl sendTextContent:str andType:WXSceneSession andUrlstr:imgUrl];
//                          }else if (index==1){ //朋友圈
//                              [theBlockCtrl sendTextContent:str andType:WXSceneTimeline andUrlstr:imgUrl];
//                          }else if (index==2){ //新浪微博
//                              [theBlockCtrl sendWBTextContent:str andUrlstr:imgUrl];
//                          }else if (index==3){ //QQ好友
//                              [theBlockCtrl shareToFriend:str andUrlstr:imgUrl];
//                          }else if (index==4){ //QQ空间
//                              [theBlockCtrl shareToQzone:str andUrlstr:imgUrl];
//                          }else if (index==5){ //腾讯微博
//                              
//                          }
//                      }];
//                  }];
}
-(void)_initData{
    theCurIndex=self.curIndex;
}
-(void)_initView{
   
    NSArray *arr= [self.theModel.imageurls componentsSeparatedByString:@";"];
    NSMutableArray* array_Url = [[NSMutableArray alloc]init];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isEqualToString:@""])
        {
            [array_Url addObject:obj];
        }
    }];
  //  NSString* string_Url =
    ALScrollView *bigShowView=[[ALScrollView alloc]
                               initWithFrame:CGRectMake(0,
                                                        0,
                                                        kScreenWidth,
                                                        self.contentView.height)];
    [bigShowView setDelegate:self];
    [bigShowView setPagingEnabled:YES];
    [array_Url enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALImageView *imgView=[[ALImageView alloc]
                              initWithFrame:CGRectMake(bigShowView.width*idx,
                                                       0,
                                                       bigShowView.width,
                                                       bigShowView.height)];
        [imgView setImageWithURL:[NSURL URLWithString:obj]
                placeholderImage:nil];
        [bigShowView addSubview:imgView];
    }];
    [self.contentView addSubview:bigShowView];
    self.contentView.backgroundColor = [UIColor blackColor];
    [bigShowView setTheViewTouchuBlock:^(id sender){
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [bigShowView setContentOffset:CGPointMake(bigShowView.width*self.curIndex, bigShowView.contentOffset.y)];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int curPage=scrollView.contentOffset.x/scrollView.width;
    theCurIndex=curPage;
}
@end
