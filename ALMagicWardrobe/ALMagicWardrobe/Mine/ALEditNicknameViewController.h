//
//  ALEditNicknameViewController.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
typedef void (^BackNewNickname)(NSString *newNickname);

/**
 *  修改昵称
 */
@interface ALEditNicknameViewController : ALBaseViewController
/**
 *  传入旧别名
 *
 *  @param name    旧别名
 *  @param theBack 回调出入新别名
 */
-(void)editName:(NSString *)name andBack:(BackNewNickname)theBack;
@end
