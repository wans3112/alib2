//
//  AVOAPICreateTripSummaryRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateTripSummaryRequest.h"

#define KEY_TRIP @"trip"
#define KEY_USERS @"users"

@implementation AVOAPICreateTripSummaryRequest
@synthesize trip, users;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.trip = [[[AVOTripSummary alloc] init] fromDictionary:[dict objectForKey:KEY_TRIP]];
        self.users = [dict objectForKey:KEY_USERS];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.trip toDictionary], KEY_TRIP, self.users, KEY_USERS, nil];
}

@end
