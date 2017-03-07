//
//  MGUI_TypeData.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/16.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TypeTheBlock)(NSString* stringId);

@interface MGUI_TypeData : UIView
@property(nonatomic)NSString* string_Type;
@property(nonatomic)NSString* string_Style;
-(void)reload:(NSString*)style Type:(NSString*)type;
@property(nonatomic,copy)TypeTheBlock theblock;
@end
