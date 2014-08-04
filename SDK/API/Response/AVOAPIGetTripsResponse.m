//
//  AVOAPIGetTripsResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIGetTripsResponse.h"

#define KEY_TRIPS @"trips"

@implementation AVOAPIGetTripsResponse
@synthesize trips;

-(id)fromDictionary:(NSDictionary *)dict{
    if(dict) {
        self.trips = [dict objectForKey:KEY_TRIPS];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for(NSDictionary *d in self.trips) {
            [tmp addObject:[[[AVOTripSummary alloc] init] fromDictionary:d]];
        }
        self.trips = tmp;
    }
    return self;
}

-(NSDictionary *)toDictionary {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for(AVOTripSummary *summary in self.trips) {
        [tmp addObject:[summary toDictionary]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:tmp, KEY_TRIPS, nil];
}

@end
