//
//  MGUI_Type.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/14.
//  Copyright (c) 2015年 anLun. All rights reserved.
//  描述：分类

#import <UIKit/UIKit.h>
typedef void (^TypeTheBlock)(NSString* stringId);
typedef void (^TypeTheMoveBlock)(NSString* stringStyle,NSString* stringType);
@interface MGUI_Type : UIView
@property(nonatomic,copy)TypeTheMoveBlock   blockMove;
@property(nonatomic,copy)TypeTheBlock theblock;
-(void)showChoose;
@end
