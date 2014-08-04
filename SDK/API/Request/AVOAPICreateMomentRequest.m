//
//  AVOAPICreateMomentRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateMomentRequest.h"

#define KEY_TRIPID @"tripID"
#define KEY_MOMENT @"moment"

@implementation AVOAPICreateMomentRequest
@synthesize tripID, moment;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.tripID = [[dict objectForKey:KEY_TRIPID] longLongValue];
        self.moment = [[[AVOMoment alloc] init] fromDictionary:[dict objectForKey:KEY_MOMENT]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.tripID], KEY_TRIPID, [self.moment toDictionary], KEY_MOMENT, nil];
}

@end
