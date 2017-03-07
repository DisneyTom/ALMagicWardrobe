//
//  ALSystemMessageDetailViewController.h
//  ALMagicWardrobe
//
//  Created by wang on 3/22/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALSysMessageModel.h"

@interface ALSystemMessageDetailViewController : ALBaseViewController
/**
 *  消息数据
 */
@property(nonatomic,strong)ALSysMessageModel *messageDataInfoModel;
@property(nonatomic,copy)NSString*expressId;

@end
