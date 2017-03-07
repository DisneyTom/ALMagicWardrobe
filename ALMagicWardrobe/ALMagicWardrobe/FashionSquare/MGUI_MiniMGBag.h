//
//  MGUI_MiniMGBag.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/24.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MiniTheBlock)();
typedef void (^MiniMoveTheBlock)();
@interface MGUI_MiniMGBag : UIView
@property (nonatomic, copy)NSString *isBuy;
@property (nonatomic,copy)MiniTheBlock theBlock;
@property (nonatomic,copy)MiniMoveTheBlock theBlockMove;
-(void)reload;
-(void)_loadIsBuyDataAndBlock:(void(^)())theBlock;
@end
