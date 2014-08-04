//
//  AVOLocalCredential.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOLocalCredential.h"

#define KEY_EMAIL @"email"
#define KEY_PASSHASH @"passHash"

@implementation AVOLocalCredential
@synthesize email, passHash;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict != nil) {
        self.email = [dict objectForKey:KEY_EMAIL];
        self.passHash = [dict objectForKey:KEY_PASSHASH];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.email, KEY_EMAIL, self.passHash, KEY_PASSHASH, nil];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:email forKey:@"email"];
    [aCoder encodeObject:passHash forKey:@"passHash"];
}
// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.passHash = [aDecoder decodeObjectForKey:@"passHash"];
        
    }
    return  self;
}

@end
