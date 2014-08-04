//
//  AVOAPICreateTripSummaryRequest.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOTripSummary.h"

@interface AVOAPICreateTripSummaryRequest : AVOCommModel

@property (nonatomic, retain) AVOTripSummary *trip;
@property (nonatomic, retain) NSArray *users;

@end
