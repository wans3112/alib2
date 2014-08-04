//
//  AVOImageLink.m
//  Avolo
//
//  Created by Zhengji Tao on 11/30/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOImageLink.h"

#define KEY_SECRET @"secret"
#define KEY_URL @"url"
#define KEY_AVAILABLE @"available"

@implementation AVOImageLink
@synthesize secret, url, avaliable;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict != nil) {
        self.secret = [dict objectForKey:KEY_SECRET];
        self.url = [dict objectForKey:KEY_URL];
        self.avaliable = [[dict objectForKey:KEY_AVAILABLE] intValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.secret, KEY_SECRET, self.url, KEY_URL, [NSNumber numberWithInt:self.avaliable], KEY_AVAILABLE, nil];
}

@end
