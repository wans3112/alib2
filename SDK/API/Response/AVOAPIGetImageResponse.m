//
//  AVOAPIGetImageResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/14/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIGetImageResponse.h"

#define KEY_IMAGE @"image"

@implementation AVOAPIGetImageResponse
@synthesize image;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.image = [[[AVOImageLink alloc] init] fromDictionary:[dict objectForKey:KEY_IMAGE]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.image toDictionary], KEY_IMAGE, nil];
}

@end
