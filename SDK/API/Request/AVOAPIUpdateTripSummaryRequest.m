//
//  AVOAPIUpdateTripSummaryRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIUpdateTripSummaryRequest.h"
#import "AVOUserTripShip.h"

#define KEY_TITLE @"title"
#define KEY_SDATE @"sdate"
#define KEY_DESTINATION @"destination"
#define KEY_BANNERID @"bannerID"
#define KEY_MEMBERS @"members"

@implementation AVOAPIUpdateTripSummaryRequest
@synthesize title, sdate, destination, bannerID, members;

-(id)fromDictionary:(NSDictionary *)dict{
    if(dict!=nil) {
        self.title = [dict objectForKey:KEY_TITLE];
        self.sdate = [[dict objectForKey:KEY_SDATE] longLongValue];
        self.destination = [dict objectForKey:KEY_DESTINATION];
        self.bannerID = [[dict objectForKey:KEY_BANNERID] longLongValue];
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
    return [NSDictionary dictionaryWithObjectsAndKeys:self.title, KEY_TITLE, [NSNumber numberWithLongLong:self.sdate], KEY_SDATE, self.destination, KEY_DESTINATION, [NSNumber numberWithLongLong:self.bannerID], KEY_BANNERID, tmp, KEY_MEMBERS, nil];
}

@end
