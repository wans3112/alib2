//
//  AVOAPICreateLocalUserTokenResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateLocalUserTokenResponse.h"

#define KEY_TOKEN @"token"

@implementation AVOAPICreateLocalUserTokenResponse
@synthesize token;

-(id)fromDictionary:(NSDictionary *)dict{
    if(dict!=nil) {
        self.token = [[[AVOUserToken alloc] init] fromDictionary:[dict objectForKey:KEY_TOKEN]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.token toDictionary], KEY_TOKEN, nil];
}

@end
