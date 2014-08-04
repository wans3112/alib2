//
//  NVIOTClientException.m
//  NVSDK2
//
//  Created by Zhengji Tao on 11/4/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import "NVIOTClientException.h"

@implementation NVIOTClientException

- (id)init {
    self = [super initWithName:@"NVIOTClientException" reason:@"nil" userInfo:nil];
    if(self) {
    }
    
    return self;
}

@end
