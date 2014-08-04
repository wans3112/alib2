//
//  AVOAPIUpdateTripMemberRequest.h
//  Avolo
//
//  Created by Zhengji Tao on 12/12/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOUserTripShip.h"

@interface AVOAPIUpdateTripMemberRequest : AVOCommModel

@property (nonatomic, retain) AVOUserTripShip *member;
@property (nonatomic, retain) NSString *tripCode;

@end
