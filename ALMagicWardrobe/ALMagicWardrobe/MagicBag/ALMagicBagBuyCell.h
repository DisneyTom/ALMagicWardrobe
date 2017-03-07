//
//  ALMagicBagBuyCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
static float magicBagBuyCellHight=60;

typedef void(^CellIndex)(NSInteger index);

@interface ALMagicBagBuyCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;

/**
 *  当前cell index
 */
@property (nonatomic, strong) CellIndex cellIndexBlock;

-(void)setDic:(NSDictionary *)dic;
-(void)selBuy:(BOOL)isSel;
@end
