//
//  AVOAPICreateLocalUserTokenRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateLocalUserTokenRequest.h"

#define KEY_LOCALCRE @"localcre"

@implementation AVOAPICreateLocalUserTokenRequest
@synthesize localcre;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.localcre = [[[AVOLocalCredential alloc] init] fromDictionary:[dict objectForKey:KEY_LOCALCRE]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.localcre toDictionary], KEY_LOCALCRE, nil];
}

@end
