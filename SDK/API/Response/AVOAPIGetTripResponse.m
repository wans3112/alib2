//
//  AVOAPIGetTripResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIGetTripResponse.h"

#define KEY_TRIP @"trip"

@implementation AVOAPIGetTripResponse
@synthesize trip;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.trip = [[[AVOTripSummary alloc] init] fromDictionary:[dict objectForKey:KEY_TRIP]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.trip toDictionary], KEY_TRIP, nil];
}

@end
