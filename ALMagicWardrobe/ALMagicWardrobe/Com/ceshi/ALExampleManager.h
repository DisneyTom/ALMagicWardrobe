//
//  ALExampleManager.h
//  ALMagicWardrobe
//
//  Created by yyq on 3/19/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#import <Foundation/Foundation.h>
#define AL_KEY_DATA_HEIGHT @"Height" //身高
#define AL_KEY_DATA_WEIGHT @"Weight"//体重
#define AL_KEY_DATA_UNDERBUST @"underBust"//
#define AL_KEY_DATA_BRASIZE @"BraSize"//
#define AL_KEY_DATA_WAIST @"Waist"//
#define AL_KEY_DATA_BUTTOCK @"Buttock"//
#define AL_KEY_DATA_SHOULDER @"Shoulder"
#define AL_KEY_DATA_NECK @"Neck"

#define AL_KEY_DATA_UPPERARM @"UpperArm"
#define AL_KEY_DATA_CALF @"Calf"
#define AL_KEY_DATA_THIGH @"Thigh"
#define AL_KEY_DATA_CLOTHINGSIZES @"ClothingSizes"
#define AL_KEY_DATA_BODYTYPE @"Bodytype"




typedef enum {
    AL_TYPE_DATA_HEIGHT,
    AL_TYPE_DATA_WEIGHT,
    AL_TYPE_DATA_UNDERBUST,
    AL_TYPE_DATA_BRASIZE,
    AL_TYPE_DATA_WAIST,
    AL_TYPE_DATA_BUTTOCK,
    AL_TYPE_DATA_SHOULDER,
    AL_TYPE_DATA_NECK,
    AL_TYPE_DATA_UPPERARM,
    AL_TYPE_DATA_CALF,
    AL_TYPE_DATA_THIGH,
    AL_TYPE_DATA_CLOTHINGSIZES,

    AL_TYPE_DATA_BODYTYPE,
    
    AL_TYPE_DATA_BUSTVALUE, //胸围
    AL_TYPE_DATA_WAISTLINEVALUE,//腰围
    AL_TYPE_DATA_HIPSVALUE,//臀围
    AL_TYPE_DATA_SHOULDERVALUE,//肩宽

    
    
    
}AL_TYPE_DATA;

@interface ALExampleManager : NSObject
{
    
}
+ (ALExampleManager *) sharedInstance;

-(void) saveHeightValue:(NSString*)value;
-(NSString*) readHeightValue;

-(void) saveWeightValue:(NSString*)value;
-(NSString*) readWeightValue;

-(void) saveUnderbustValue:(NSString*)value;
-(NSString*) readUnderbustValue;
-(void) saveBarSizeValue:(NSString*)value;
-(NSString*) readBarSizeValue;


-(void) saveWaistValue:(id)value;
-(id) readWaistValue;

-(void) saveButtockValue:(id)value;
-(id) readButtocktValue;

-(void) saveShoulderValue:(id)value;
-(id) readShoulderValue;

-(void) saveNeckValue:(id)value;
-(id) readNeckValue;


-(void) saveUpperArmValue:(id)value;
-(id) readUpperArmValue;

-(void) saveCalfValue:(id)value;
-(id) readCalfValue;

-(void) saveThighValue:(id)value;
-(id) readThighValue;

-(void) saveClothingSizesValue:(id)value;
-(id) readClothingSizesValue;


//Types
-(void) saveValueWithType:(AL_TYPE_DATA)type value:(id)value;
-(id) readValueWithType:(AL_TYPE_DATA)type;



@end
