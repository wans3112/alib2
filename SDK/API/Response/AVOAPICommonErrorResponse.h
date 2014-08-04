//
//  AVOAPICommonErrorResponse.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOAPICommonErrorResponse : AVOCommModel

@property (nonatomic) int errCode;
@property (nonatomic, retain) NSString *errMsg;

@end
