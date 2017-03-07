//
//  ALButtonViews.h
//  ALMagicWardrobe
//
//  Created by yyq on 3/19/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ALButtonViewsDelegate <NSObject>
@optional
-(void) ALButtonViewsHandle:(id)data thread:(id)thread value:(id)value;

@end

typedef enum {
    ALBUTTON_SHOW_TYPE_TITLE,
    ALBUTTON_SHOW_TYPE_IMAGE,
}ALBUTTON_SHOW_TYPE;

@interface ALButtonViews : UIView
{
    NSArray *alArrayList;
    id alSelected;
    id alDataValue;
    id<ALButtonViewsDelegate> delegate;
    id alShowType;
}
@property (nonatomic) NSArray *alArrayList;
@property (nonatomic) id alSelected;
@property (nonatomic) id alDataValue;
@property (nonatomic) id<ALButtonViewsDelegate> delegate;
@property (nonatomic)  id alShowType;

-(void)refreshShowViews:(CGSize)showSize titleColor:titleColor fontSize:(CGFloat)fontSize;
-(void)refreshShowImagaViews:(CGSize)showSize; //image

@end
