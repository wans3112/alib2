//
//  AVOAPICreateLocalUserTokenRequest.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOLocalCredential.h"

@interface AVOAPICreateLocalUserTokenRequest : AVOCommModel

@property (nonatomic, retain) AVOLocalCredential *localcre;

@end
