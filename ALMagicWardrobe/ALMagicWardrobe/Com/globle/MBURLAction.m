//
//  MBURLAction.m
//  BOCMBCI
//
//  Created by Tracy E on 13-5-6.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import "MBURLAction.h"

@implementation MBURLAction


+ (id)action{
    return [[MBURLAction alloc] init];
}

+ (id)actionWithURLPath:(NSString *)urlPath{
    return [[MBURLAction alloc] initWithURLPath:urlPath];
}

- (id)init{
    self = [self initWithURLPath:nil];
    if (self) {
    }
    return self;
}

- (id)initWithURLPath:(NSString *)urlPath{
    self = [super init];
    if (self) {
        self.urlPath = urlPath;
    }
    return self;
}

- (MBURLAction *)applyClassName:(NSString *)className{
    self.className = className;
    return self;
}

- (MBURLAction *)applyTitle:(NSString *)title{
    self.title = title;
    return self;
}

- (MBURLAction *)applyImageName:(NSString *)imageName{
    self.imageName = imageName;
    return self;
}

- (MBURLAction *)applyOffline:(BOOL)offline{
    self.offline = offline;
    return self;
}


- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %p> URL:%@ Class:%@ Image:%@ Tag:%@",[self class],self,_urlPath,_className,_imageName,_title];
}

@end
