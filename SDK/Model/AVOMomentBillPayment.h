//
//  AVOMomentBillPayment.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOUser.h"

@interface AVOMomentBillPayment : AVOCommModel

@property (nonatomic) long long paymentID;
@property (nonatomic) long long billID;
@property (nonatomic) long long userID;
@property (nonatomic) double paid;
@property (nonatomic) double consumed;

@property (nonatomic, strong) AVOUser *user;

@end
