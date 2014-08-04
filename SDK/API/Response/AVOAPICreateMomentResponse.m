//
//  AVOAPICreateMomentResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateMomentResponse.h"

#define KEY_MOMENTID @"momentID"
#define KEY_BILLID @"momentBillID"
#define KEY_NOTEID @"momentNoteID"
#define KEY_PHOTOID @"momentPhotoID"

@implementation AVOAPICreateMomentResponse
@synthesize momentID, momentBillID, momentNoteID, momentPhotoID;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.momentID = [[dict objectForKey:KEY_MOMENTID] longLongValue];
        self.momentBillID = [[dict objectForKey:KEY_BILLID] longLongValue];
        self.momentNoteID = [[dict objectForKey:KEY_NOTEID] longLongValue];
        self.momentPhotoID = [[dict objectForKey:KEY_PHOTOID] longLongValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.momentID], KEY_MOMENTID, [NSNumber numberWithLongLong:self.momentBillID], KEY_BILLID, [NSNumber numberWithLongLong:self.momentNoteID], KEY_NOTEID, [NSNumber numberWithLongLong:self.momentPhotoID], KEY_PHOTOID, nil];
}

@end
