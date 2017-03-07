//
//  ALExampleManager.m
//  ALMagicWardrobe
//
//  Created by yyq on 3/19/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import "ALExampleManager.h"


@interface ALExampleManager ()
{
    NSMutableDictionary *alDictionaryValues;
}
@end

@implementation ALExampleManager

+ (ALExampleManager *) sharedInstance
{
    //单例对象
    static ALExampleManager *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        alDictionaryValues = [NSMutableDictionary dictionary];
    }
    return self;
}


-(void) saveHeightValue:(NSString*)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_HEIGHT];
    }
}
-(NSString*) readHeightValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_HEIGHT];
}


-(void) saveWeightValue:(NSString*)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_WEIGHT];
    }
}
-(NSString*) readWeightValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_WEIGHT];
}

-(void) saveUnderbustValue:(NSString*)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_UNDERBUST];
    }
}
-(NSString*) readUnderbustValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_UNDERBUST];
}

-(void) saveBarSizeValue:(NSString*)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_BRASIZE];
    }
}
-(NSString*) readBarSizeValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_BRASIZE];
}


-(void) saveWaistValue:(id)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_WAIST];
    }
}
-(id) readWaistValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_WAIST];
}


-(void) saveButtockValue:(id)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_BUTTOCK];
    }
}
-(id) readButtocktValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_BUTTOCK];
}



-(void) saveShoulderValue:(id)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_SHOULDER];
    }
}
-(id) readShoulderValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_SHOULDER];
}

-(void) saveNeckValue:(id)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_NECK];
    }
}
-(id) readNeckValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_NECK];
}

-(void) saveUpperArmValue:(id)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_UPPERARM];
    }
}
-(id) readUpperArmValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_UPPERARM];
}

-(void) saveCalfValue:(id)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_CALF];
    }
}
-(id) readCalfValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_CALF];
}

-(void) saveThighValue:(id)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_THIGH];
    }
}
-(id) readThighValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_THIGH];
}
//ClothingSizes
-(void) saveClothingSizesValue:(id)value
{
    if (value) {
        [alDictionaryValues setValue:value forKey:AL_KEY_DATA_CLOTHINGSIZES];
    }
}
-(id) readClothingSizesValue
{
    return [alDictionaryValues objectForKey:AL_KEY_DATA_CLOTHINGSIZES];
}


//====优化

-(void) saveValueWithType:(AL_TYPE_DATA)type value:(id)value
{
    NSString *keys = [NSString stringWithFormat:@"AL_KEY_TYPE_%d", type];
    if (value) {
        [alDictionaryValues setValue:value forKey:keys];
    }
    
}
-(id) readValueWithType:(AL_TYPE_DATA)type
{
    NSString *keys = [NSString stringWithFormat:@"AL_KEY_TYPE_%d", type];
    return [alDictionaryValues objectForKey:keys];
}


@end
