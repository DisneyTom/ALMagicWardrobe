//
//  MGUI_Popularity.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/12.
//  Copyright (c) 2015年 anLun. All rights reserved.
//  描述:人气

#import <UIKit/UIKit.h>
typedef void (^PopularityViewBlock)(NSString* modeId);
typedef void (^PopularityViewTopBlock)(BOOL isTop);
@interface MGUI_Popularity : UIView
@property(nonatomic,copy) PopularityViewBlock theBlock; //跳转到人气详情界面的Block 在魔法广场控制器 实现 主要将modeId传递给详情界面
@property(nonatomic,copy) PopularityViewTopBlock block; // 置顶按钮的触发Block 判断偏移量是否超过一个屏幕高
-(void)toTop;
@end
