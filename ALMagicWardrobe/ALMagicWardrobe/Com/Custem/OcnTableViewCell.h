//
//  OcnTableViewCell.h
//  testCell
//
//  Created by OCN on 15-1-22.
//  Copyright (c) 2015年 OCN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OcnTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
          andCanHua:(BOOL)isHua;

@property(nonatomic,strong) UIView *actualContentView;

-(void)setImages:(NSArray *)imgArr
          orTits:(NSArray *)titArr
         andBack:(void(^)(NSInteger index))theBack;
@end
