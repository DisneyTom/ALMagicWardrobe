//
//  ALBaseModel.h
//  GameRec
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALBaseModel : NSObject<NSCoding,NSCopying>

-(id)initWithDataDic:(NSDictionary*)data;
/**
 *  创建请求返回字典的key和model中key的对应关系字典，注：object为返回数据中值，key为model的key
 *
 *  @return 返回创建好的关系字典
 */
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;
@end
