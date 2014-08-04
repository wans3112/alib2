//
//  AVOKeyManager.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOLocalCredential.h"
#import "AVOUserToken.h"

@protocol AVOKeyManager <NSObject>

- (void) storeUserCredential:(AVOLocalCredential *) credential;

- (AVOLocalCredential *) loadUserCredential;

- (void) storeToken:(AVOUserToken *) token;

- (AVOUserToken *) loadToken;

- (void) removeUserCredential;

- (void) removeAllToken;


@end
