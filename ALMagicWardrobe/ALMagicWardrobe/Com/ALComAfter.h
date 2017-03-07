//
//  ALComAfter.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//
#import "ALComAction.h"

#ifndef ALMagicWardrobe_ALComAfter_h
#define ALMagicWardrobe_ALComAfter_h

#define colorByStr(__VAL__) ([[ALComAction sharedInstance] colorWithHexString:__VAL__])
#define filterStr(__VAL__) ([ALComAction filterStr:__VAL__])
#define showWarn(__VAL__) ([[ALComAction sharedInstance] showLoadWarn:__VAL__])
#define showFail(__VAL__)  ([[ALComAction sharedInstance] showFail:__VAL__])
#define showRequest ([[ALComAction sharedInstance] requestShowOrHide:YES])
#define hideRequest ([[ALComAction sharedInstance] requestShowOrHide:NO])
#endif
