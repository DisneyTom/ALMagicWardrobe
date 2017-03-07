//
//  ALGetCodeViewController.h
//  ALMagicWardrobe
//
//  Created by wang on 4/12/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
#import "ALSysMessageModel.h"
/**
 *  系统消息 邀请码
 */
@interface ALGetCodeViewController : ALBaseViewController
@property(nonatomic,strong)ALSysMessageModel *messageDataInfoModel;
@property(nonatomic,copy)NSString*codeMessage;
@end
