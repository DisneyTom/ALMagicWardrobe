//
//  MGUI_ForYou.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/12.
//  Copyright (c) 2015年 anLun. All rights reserved.
//  描述：为你精选

#import <UIKit/UIKit.h>
typedef  void (^ForYouTheBlock)();
typedef void (^ForYouViewBlock)(NSString* modeId);
typedef void (^ForYouViewTopBlock)(BOOL isTop);
typedef void (^ForYouViewFirstBlock)();
@interface MGUI_ForYou : UIView
@property(nonatomic,copy)ForYouTheBlock theBlock;
@property(nonatomic,copy) ForYouViewBlock theViewBlock;
@property(nonatomic,copy) ForYouViewTopBlock block;
@property(nonatomic,copy) ForYouViewFirstBlock firstBlock;
-(void)toTop;
-(void)reload;
@end
