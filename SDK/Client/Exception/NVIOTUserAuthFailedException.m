//
//  NVIOTUserAuthFailedException.m
//  NVSDK2
//
//  Created by Zhengji Tao on 11/4/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import "NVIOTUserAuthFailedException.h"

@implementation NVIOTUserAuthFailedException

-(id)init {
    self = [super initWithErrCode:401];
    if (self) {
    }
    
    return self;
}

@end
