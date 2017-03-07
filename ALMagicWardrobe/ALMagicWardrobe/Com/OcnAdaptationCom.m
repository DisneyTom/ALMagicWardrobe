//
//  OcnAdaptationCom.m
//  OcnO2O
//
//  Created by anLun on 15-2-11.
//  Copyright (c) 2015年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import "OcnAdaptationCom.h"

@implementation OcnAdaptationCom

CGRect ALRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    
    float ALScreenWidth=[[UIScreen mainScreen] bounds].size.width;
    float ALScreenHeight= [[UIScreen mainScreen] bounds].size.height;
    
    float autoSizeScaleX=0;
    float autoSizeScaleY=0;
    
    if (ALScreenHeight>480) {
        autoSizeScaleX = ALScreenWidth/320;
        autoSizeScaleY = ALScreenHeight/568;
    }
    else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    
    return rect;
}

@end
