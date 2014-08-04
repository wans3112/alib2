//
//  AVOTripSummary.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOTripSummary : AVOCommModel

@property (nonatomic) long long tripID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic) long long sdate;
@property (nonatomic, retain) NSString *destination;
@property (nonatomic) long long bannerID;
@property (nonatomic, retain) NSString *inviteCode;
@property (nonatomic) int members;
@property (nonatomic) enum AVO_UserTripShipStatus status;

@property (strong, nonatomic) UIImage *bannerImage;
@property (strong, nonatomic) NSMutableArray *personArray,*locationArray,*momentArray;
@property (strong, nonatomic) NSString *bannerUrl;
@property (nonatomic, strong) NSDate *date;

@end
