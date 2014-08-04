//
//  NVIOTServiceException.h
//  NVSDK2
//
//  Created by Zhengji Tao on 11/4/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import "NVIOTClientException.h"

@interface NVIOTServiceException : NVIOTClientException

@property (nonatomic) NSInteger errCode;

- (id) initWithErrCode:(NSInteger) code;

@end
