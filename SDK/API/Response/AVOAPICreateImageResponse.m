//
//  AVOAPICreateImageResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateImageResponse.h"

#define KEY_IMAGEID @"imageID"
#define KEY_IMAGELINK @"imageLink"

@implementation AVOAPICreateImageResponse
@synthesize imageID, imageLink;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.imageID = [[dict objectForKey:KEY_IMAGEID] longLongValue];
        self.imageLink = [[[AVOImageLink alloc] init] fromDictionary:[dict objectForKey:KEY_IMAGELINK]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.imageID], KEY_IMAGEID, [self.imageLink toDictionary], KEY_IMAGELINK, nil];
}

@end
