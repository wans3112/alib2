//
//  AVOAPIUpdateTripSummaryRequest.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOAPIUpdateTripSummaryRequest : AVOCommModel

@property (nonatomic, retain) NSString *title;
@property (nonatomic) long long sdate;
@property (nonatomic, retain) NSString *destination;
@property (nonatomic) long long bannerID;
@property (nonatomic, retain) NSArray *members;

@end
