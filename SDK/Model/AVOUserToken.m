//
//  AVOUserToken.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOUserToken.h"

#define KEY_TOKEN @"token"
#define KEY_EXPIRES @"expires"
#define KEY_USERID @"userID"

@implementation AVOUserToken
@synthesize token, expires, userID;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.token = [dict objectForKey:KEY_TOKEN];
        self.expires = [[dict objectForKey:KEY_EXPIRES] longLongValue];
        self.userID = [[dict objectForKey:KEY_USERID] longLongValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.token, KEY_TOKEN, [NSNumber numberWithLongLong:self.expires], KEY_EXPIRES, [NSNumber numberWithLongLong:self.userID], KEY_USERID, nil];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:token forKey:@"token"];
    [aCoder encodeObject:[NSNumber numberWithLongLong:expires] forKey:@"expires"];
    [aCoder encodeObject:[NSNumber numberWithLongLong:userID] forKey:@"userID"];
}
// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.expires = [[aDecoder decodeObjectForKey:@"expires"] longLongValue];
        self.userID = [[aDecoder decodeObjectForKey:@"userID"] longLongValue];
    }
    return  self;
}

@end
