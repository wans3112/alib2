//
//  NVInMemoryKeyMananger.m
//  NVSDK2
//
//  Created by Zhengji Tao on 11/7/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import "NVInMemoryKeyMananger.h"

@implementation NVInMemoryKeyMananger
@synthesize userCredential, tokens;

- (id)init {
    self  = [super init];
    if(self) {
    }
    
    return self;
}

- (AVOLocalCredential *)loadUserCredential {
    return self.userCredential;
}

- (void)storeUserCredential:(AVOLocalCredential *)credential {
    self.userCredential = credential;
}

- (AVOUserToken *)loadToken {
    return self.tokens;
}

- (void)storeToken:(AVOUserToken *)token {
    self.tokens = token;
}

- (void)removeUserCredential {
    self.userCredential = nil;
}

- (void)removeAllToken {
    self.tokens = nil;
}


@end
