//
//  AVOAPIUpdateUserRequest.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOUser.h"

@interface AVOAPIUpdateUserRequest : AVOCommModel

@property (nonatomic, retain) AVOUser *user;

@end
