//
//  ALNineProductView.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALComView.h"
@class ALTestModel;
@interface ALNineProductView : ALScrollView
@property(nonatomic,copy) BackBlock theBlock;
@property(nonatomic,copy) BackBlock theComitBlock;
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock;
@end
