//
//  NVInMemoryKeyMananger.m
//  NVSDK2
//
//  Created by Zhengji Tao on 11/7/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import "NVInDiskKeyMananger.h"

@implementation NVInDiskKeyMananger
@synthesize userCredential, tokens;

SYNTHESIZE_SINGLETON_FOR_CLASS(NVInDiskKeyMananger);

- (id)init {
    self  = [super init];
    if(self) {
    }
    return self;
}

- (AVOLocalCredential *)loadUserCredential {
    if (!self.userCredential) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_CREDENTIAL];
        self.userCredential = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"self.userCredential: %@, stu.name: %@",self.userCredential,self.userCredential.email);
    }
    return self.userCredential;
}

- (void)storeUserCredential:(AVOLocalCredential *)credential {
    self.userCredential = credential;
    
    if (self.userCredential) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.userCredential];
        [userDefault setObject:data forKey:USER_CREDENTIAL];
        [userDefault synchronize];
    }
}

- (AVOUserToken *)loadToken{
    if (!self.tokens) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        self.tokens = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"self.tokens: %@, token: %@,userID:%lld",self.tokens,self.tokens.token,self.tokens.userID);
    }
    return self.tokens;
}

- (void)storeToken:(AVOUserToken *)token {
    self.tokens = token;
    if (self.tokens) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:token];
        [userDefault setObject:data forKey:USER_TOKEN];
        [userDefault synchronize];
    }
}

- (void)removeUserCredential {
    self.userCredential=nil;
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:USER_CREDENTIAL];
    [userDefault synchronize];
}

- (void)removeAllToken {
    self.tokens=nil;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:USER_TOKEN];
    [userDefault synchronize];
}

@end
