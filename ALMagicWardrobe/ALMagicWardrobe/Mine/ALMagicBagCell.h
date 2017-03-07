//
//  ALMagicBagCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-14.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALMagicBagCell : UITableViewCell
-(void)setMagicDic:(NSDictionary *)magicDic
            andSel:(BOOL)isSel
      andSelAction:(void(^)(BOOL sel))theBlock;
@end
