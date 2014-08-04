//
//  AVOMomentBillDetail.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOMomentBillDetail.h"

#define KEY_SUMMARY @"summary"
#define KEY_IMAGEID @"imageID"
#define KEY_NOTE @"note"

@implementation AVOMomentBillDetail
@synthesize summary, imageID, note;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict != nil) {
        self.summary = [[[AVOMomentBill alloc] init] fromDictionary:[dict objectForKey:KEY_SUMMARY]];
        self.imageID = [[dict objectForKey:KEY_IMAGEID] longLongValue];
        self.note = [dict objectForKey:KEY_NOTE];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.summary toDictionary], KEY_SUMMARY, [NSNumber numberWithLongLong:self.imageID], KEY_IMAGEID, self.note, KEY_NOTE, nil];
}

@end
