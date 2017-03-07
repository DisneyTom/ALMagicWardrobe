//
//  ALBlockUIAlertView.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-12.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AlertBlock)(NSInteger index);
@interface ALBlockUIAlertView : UIAlertView
@property(nonatomic,copy) AlertBlock theBlock;
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
       buttonTitles:(NSArray *)buttonTitles
        clickButton:(AlertBlock)_block;
@end
