//
//  NVInMemoryKeyMananger.h
//  NVSDK2
//
//  Created by Zhengji Tao on 11/7/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVOKeyManager.h"

@interface NVInMemoryKeyMananger : NSObject <AVOKeyManager>

@property (nonatomic, retain) AVOLocalCredential *userCredential;
@property (nonatomic, retain) AVOUserToken *tokens;

@end
