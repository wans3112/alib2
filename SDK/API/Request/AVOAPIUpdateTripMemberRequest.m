//
//  AVOAPIUpdateTripMemberRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/12/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIUpdateTripMemberRequest.h"

#define KEY_MEMBER @"member"
#define KEY_TRIPCODE @"tripCode"

@implementation AVOAPIUpdateTripMemberRequest
@synthesize member, tripCode;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.member = [[[AVOUserTripShip alloc] init] fromDictionary:[dict objectForKey:KEY_MEMBER]];
        self.tripCode = [dict objectForKey:KEY_TRIPCODE];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.member toDictionary], KEY_MEMBER, self.tripCode, KEY_TRIPCODE, nil];
}

@end
