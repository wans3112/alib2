//
//  AVOAPIGetTripMembersResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/12/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIGetTripMembersResponse.h"
#import "AVOUserTripShip.h"

#define KEY_MEMBERS @"members"

@implementation AVOAPIGetTripMembersResponse
@synthesize members;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.members = [dict objectForKey:KEY_MEMBERS];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for(NSDictionary *d in self.members) {
            [tmp addObject:[[[AVOUserTripShip alloc] init] fromDictionary:d]];
        }
        self.members = tmp;
    }
    return self;
}

-(NSDictionary *)toDictionary {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for(AVOUserTripShip *ship in self.members) {
        [tmp addObject:[ship toDictionary]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:tmp, KEY_MEMBERS, nil];
}

@end
