//
//  AVOAPICreateLocalUserResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/12/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateLocalUserResponse.h"

#define KEY_USERID @"userID"

@implementation AVOAPICreateLocalUserResponse
@synthesize userID;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.userID = [[dict objectForKey:KEY_USERID] longLongValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.userID], KEY_USERID, nil];
}

@end
