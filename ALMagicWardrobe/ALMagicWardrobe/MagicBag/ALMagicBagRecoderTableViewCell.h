//
//  ALMagicBagRecoderTableViewCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
static float recoderHeight=(30+40+600/4+1);

typedef void (^RecoderCellBlock)(id sender);

@interface ALMagicBagRecoderTableViewCell : UITableViewCell
@property(nonatomic,copy) RecoderCellBlock theBlock;
-(void)setDic:(NSDictionary *)dic;
@end
