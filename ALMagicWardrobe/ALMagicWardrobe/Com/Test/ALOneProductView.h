//
//  ALOneProductView.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALComView.h"
@class ALTestModel;
@interface ALOneProductView : ALScrollView
@property(nonatomic,copy) BackBlock theBlock;
-(id)initWithFrame:(CGRect)frame andBackBlock:(BackBlock)theBlock;
@end
