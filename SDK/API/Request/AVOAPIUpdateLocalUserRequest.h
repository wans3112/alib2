//
//  AVOAPIUpdateLocalUserRequest.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOAPIUpdateLocalUserRequest : AVOCommModel

@property (nonatomic, retain) NSString *oriPass;
@property (nonatomic, retain) NSString *nePass;

@end
