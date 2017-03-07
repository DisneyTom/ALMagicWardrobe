//
//  ALBaseModel.m
//  GameRec
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#import "ALBaseModel.h"

@implementation ALBaseModel

-(id)initWithDataDic:(NSDictionary*)data{
	if (self = [super init]) {
		[self setAttributes:data];
	}
	return self;
}
-(NSDictionary*)attributeMapDictionary{
	return nil;
}

-(SEL)setSetterSelWithAttibuteName:(NSString*)attributeName{
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}
-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName
{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"get%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}
- (NSString *)customDescription{
	return nil;
}

//- (NSString *)description{
//	NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
//	NSDictionary *attrMapDic = [self attributeMapDictionary];
//	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
//	id attributeName;
//	
//	while ((attributeName = [keyEnum nextObject])) {
//		SEL getSel = NSSelectorFromString(attributeName);
//		if ([self respondsToSelector:getSel]) {
//			NSMethodSignature *signature = nil;
//			signature = [self methodSignatureForSelector:getSel];
//			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//			[invocation setTarget:self];
//			[invocation setSelector:getSel];
//			NSObject *valueObj = nil;
//			[invocation invoke];
//			[invocation getReturnValue:&valueObj];
//			if (valueObj) {
//				[attrsDesc appendFormat:@" [%@=%@] ",attributeName,valueObj];
//				//[valueObj release];
//			}else {
//				[attrsDesc appendFormat:@" [%@=nil] ",attributeName];
//			}
//			
//		}
//	}
//	
//	NSString *customDesc = [self customDescription];
//	NSString *desc;
//	
//	if (customDesc && [customDesc length] > 0 ) {
//		desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
//	}else {
//		desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
//	}
//	
//	return desc;
//}
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
-(void)setAttributes:(NSDictionary*)dataDic{
    if (![dataDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL sel = [self setSetterSelWithAttibuteName:attributeName];
		if ([self respondsToSelector:sel]) {
			NSString *dataDicKey = [attrMapDic objectForKey:attributeName];
            id value=[dataDic objectForKey:dataDicKey];
            if ([value isKindOfClass:[NSNumber class]]) {
                value=[NSString stringWithFormat:@"%@",value];
            }
            if (![value isKindOfClass:[NSObject class]]) {
//                NSLog(@"anlun%@",value);
            }
            if ([value isKindOfClass:[NSNull class]]) {
                value=filterStr(nil);
            }
			[self performSelectorOnMainThread:sel
                                   withObject:value
                                waitUntilDone:[NSThread isMainThread]];
		}
    }
    
    
}
- (id)initWithCoder:(NSCoder *)decoder{
	if( self = [super init] ){
		NSDictionary *attrMapDic = [self attributeMapDictionary];
		if (attrMapDic == nil) {
			return self;
		}
		NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
		id attributeName;
		while ((attributeName = [keyEnum nextObject])) {
			SEL sel = [self setSetterSelWithAttibuteName:attributeName];
			if ([self respondsToSelector:sel]) {
				id obj = [decoder decodeObjectForKey:attributeName];
				[self performSelectorOnMainThread:sel
                                       withObject:obj
                                    waitUntilDone:[NSThread isMainThread]];
			}
		}
	}
	return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL getSel = NSSelectorFromString(attributeName);
		if ([self respondsToSelector:getSel]) {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			
			if (valueObj) {
                
				[encoder encodeObject:valueObj forKey:attributeName];
			}
		}
	}
}
- (NSData*)getArchivedData{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}

@end
