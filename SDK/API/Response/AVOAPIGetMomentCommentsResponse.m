//
//  AVOAPIGetMomentCommentsResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/10/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIGetMomentCommentsResponse.h"

#define KEY_MOMENT_ID @"momentID"
#define KEY_COMMENTS @"comments"

@implementation AVOAPIGetMomentCommentsResponse
@synthesize momentID, comments;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.momentID = [[dict objectForKey:KEY_MOMENT_ID] longLongValue];
        self.comments = [dict objectForKey:KEY_COMMENTS];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for(NSDictionary *d in self.comments) {
            [tmp addObject:[[[AVOMomentComment alloc] init] fromDictionary:d]];
        }
        self.comments = tmp;
    }
    return self;
}

-(NSDictionary *)toDictionary {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for(AVOMomentComment *comment in self.comments){
        [tmp addObject:[comment toDictionary]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.momentID], KEY_MOMENT_ID, tmp, KEY_COMMENTS, nil];
}

@end
