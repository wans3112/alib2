//
//  AVOAPIGetMomentsResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIGetMomentsResponse.h"
#import "AVOMoment.h"

#define KEY_MOMENTS @"moments"

@implementation AVOAPIGetMomentsResponse
@synthesize moments;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.moments = [dict objectForKey:KEY_MOMENTS];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for(NSDictionary *d in self.moments) {
            [tmp addObject:[[[AVOMoment alloc] init] fromDictionary:d]];
        }
        self.moments = tmp;
    }
    return self;
}

-(NSDictionary *)toDictionary {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for(AVOMoment *moment in self.moments) {
        [tmp addObject:[moment toDictionary]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:tmp, KEY_MOMENTS, nil];
}

@end
