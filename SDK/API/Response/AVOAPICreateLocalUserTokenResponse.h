//
//  AVOAPICreateLocalUserTokenResponse.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOUserToken.h"

@interface AVOAPICreateLocalUserTokenResponse : AVOCommModel

@property (nonatomic, retain) AVOUserToken *token;

@end
