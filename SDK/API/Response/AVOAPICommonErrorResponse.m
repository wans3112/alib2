//
//  AVOAPICommonErrorResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICommonErrorResponse.h"

#define KEY_ERRCODE @"code"
#define KEY_ERRMSG @"msg"

@implementation AVOAPICommonErrorResponse
@synthesize errCode, errMsg;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil){
        self.errCode = [[dict objectForKey:KEY_ERRCODE] intValue];
        self.errMsg = [dict objectForKey:KEY_ERRMSG];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.errCode], KEY_ERRCODE, self.errMsg, KEY_ERRMSG, nil];
}

@end
