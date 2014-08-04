//
//  AVOAPICreateMomentRequest.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOMoment.h"

@interface AVOAPICreateMomentRequest : AVOCommModel

@property (nonatomic) long long tripID;
@property (nonatomic, retain) AVOMoment *moment;

@end
