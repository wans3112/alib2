//
//  AVOUserTripShip.h
//  Avolo
//
//  Created by Zhengji Tao on 12/12/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOUser.h"

@interface AVOUserTripShip : AVOCommModel

@property (nonatomic) long long ID;
@property (nonatomic) long long userID;
@property (nonatomic) long long tripID;
@property (nonatomic) enum AVO_UserTripShipStatus status;

@property (nonatomic , strong) AVOUser *mUser;
@property (assign, nonatomic) double consumedTotal,paidTotal;
@property (strong, nonatomic) NSMutableArray *payments;

@end
