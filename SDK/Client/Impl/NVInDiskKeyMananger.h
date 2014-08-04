//
//  NVInMemoryKeyMananger.h
//  NVSDK2
//
//  Created by Zhengji Tao on 11/7/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVOKeyManager.h"
#import "ARCSingletonTemplate.h"

#define USER_CREDENTIAL @"userCredential"
#define USER_TOKEN @"userToken"


@interface NVInDiskKeyMananger : NSObject <AVOKeyManager>

SYNTHESIZE_SINGLETON_FOR_HEADER(NVInDiskKeyMananger);

@property (nonatomic, retain) AVOLocalCredential *userCredential;
@property (nonatomic, retain) AVOUserToken *tokens;
@end
