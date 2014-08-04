//
//  AVOAPICreateLocalUserRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateLocalUserRequest.h"

#define KEY_USER @"user"
#define KEY_LOCALCRE @"localcre"

@implementation AVOAPICreateLocalUserRequest
@synthesize user, localcre;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.user = [[[AVOUser alloc] init] fromDictionary:[dict objectForKey:KEY_USER]];
        self.localcre = [[[AVOLocalCredential alloc] init] fromDictionary:[dict objectForKey:KEY_LOCALCRE]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.user toDictionary], KEY_USER, [self.localcre toDictionary], KEY_LOCALCRE, nil];
}

@end
