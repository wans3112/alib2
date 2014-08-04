//
//  AVOAPIGetUserResponse.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOUser.h"

@interface AVOAPIGetUserResponse : AVOCommModel

@property (nonatomic, retain) AVOUser *user;

@end
