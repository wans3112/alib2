//
//  NVIOTServiceException.m
//  NVSDK2
//
//  Created by Zhengji Tao on 11/4/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import "NVIOTServiceException.h"

@implementation NVIOTServiceException
@synthesize errCode;

- (id) initWithErrCode:(NSInteger)code {
    self = [super initWithName:@"NVIOTServiceException" reason:[NSString stringWithFormat:@"%d", code] userInfo:nil];
    if (self) {
        self.errCode = code;
    }
    
    return self;
}

@end
