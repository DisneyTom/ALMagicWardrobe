//
//  MBURLAction.h
//  BOCMBCI
//
//  Created by Tracy E on 13-5-6.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBURLAction : NSObject

@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL offline;

+ (id)action;
+ (id)actionWithURLPath:(NSString *)urlPath;

- (id)initWithURLPath:(NSString *)urlPath;

- (MBURLAction *)applyTitle:(NSString *)title;
- (MBURLAction *)applyClassName:(NSString *)className;
- (MBURLAction *)applyImageName:(NSString *)imageName;
- (MBURLAction *)applyOffline:(BOOL)offline;

@end
