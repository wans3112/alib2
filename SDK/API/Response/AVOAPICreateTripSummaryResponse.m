//
//  AVOAPICreateTripSummaryResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateTripSummaryResponse.h"

#define KEY_TRIPID @"tripID"

@implementation AVOAPICreateTripSummaryResponse
@synthesize tripID;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.tripID = [[dict objectForKey:KEY_TRIPID] longLongValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.tripID], KEY_TRIPID, nil];
}

@end
