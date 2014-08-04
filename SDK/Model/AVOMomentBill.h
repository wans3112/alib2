//
//  AVOMomentBill.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOMomentBill : AVOCommModel

@property (nonatomic) long long billID;
@property (nonatomic) double amout;
@property (nonatomic) enum AVO_BillCurrency currency;
@property (nonatomic, retain) NSString *category;
@property (nonatomic) long long date;

@property (nonatomic, assign) double paid;
@property (nonatomic, retain) NSDate *sdate;
@property (nonatomic, retain) UIImage *capImage;
@property (nonatomic, retain) NSString *capUrl;
@property (nonatomic, retain) NSString *node;

@end
