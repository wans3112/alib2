//
//  AVOAPIUpdateMomentBillRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIUpdateMomentBillRequest.h"

#define KEY_IMAGEID @"imageID"
#define KEY_NOTE @"note"

@implementation AVOAPIUpdateMomentBillRequest
@synthesize imageID, note;

-(id)fromDictionary:(NSDictionary *)dict{
    if(dict!=nil) {
        self.imageID = [[dict objectForKey:KEY_IMAGEID] longLongValue];
        self.note = [dict objectForKey:KEY_NOTE];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.imageID], KEY_IMAGEID, self.note, KEY_NOTE, nil];
}

@end
