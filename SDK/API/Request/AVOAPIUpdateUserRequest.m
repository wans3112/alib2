//
//  AVOAPIUpdateUserRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIUpdateUserRequest.h"

#define KEY_USER @"user"

@implementation AVOAPIUpdateUserRequest
@synthesize user;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.user = [[[AVOUser alloc] init] fromDictionary:[dict objectForKey:KEY_USER]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.user toDictionary], KEY_USER, nil];
}

@end
