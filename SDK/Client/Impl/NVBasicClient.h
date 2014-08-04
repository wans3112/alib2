//
//  NVBasicClient.h
//  NVSDK2
//
//  Created by Zhengji Tao on 11/2/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVOClient.h"
#import "AVOKeyManager.h"
#import "AVOAPIConstants.h"

@interface NVBasicClient : NSObject <AVOClient>

@property (nonatomic, retain) id<AVOKeyManager> keyManager;
@property (nonatomic, retain) AVOLocalCredential *userCredential;
@property (nonatomic, retain) AVOUserToken *userToken;

- (instancetype) initWithKeyManager:(id<AVOKeyManager>) km;

@end
