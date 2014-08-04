//
//  AVOAPIUpdateLocalUserRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIUpdateLocalUserRequest.h"

#define KEY_ORIPASS @"oriPass"
#define KEY_NEWPASS @"newPass"

@implementation AVOAPIUpdateLocalUserRequest
@synthesize oriPass, nePass;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.oriPass = [dict objectForKey:KEY_ORIPASS];
        self.nePass = [dict objectForKey:KEY_NEWPASS];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.oriPass, KEY_ORIPASS, self.nePass, KEY_NEWPASS, nil];
}

@end
