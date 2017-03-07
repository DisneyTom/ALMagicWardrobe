//
//  ALMagicBagFirstEnterView.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-20.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALComView.h"

/**
 *  首次进入 View
 */
@interface ALMagicBagFirstEnterView : ALComView
-(id)initWithFrame:(CGRect)frame andBackBlock:(void(^)(id sender))theBlock;
@end
@interface ALListLbl : ALComView
-(void)setTit:(NSString *)tit;
@end