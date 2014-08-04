//
//  AVOMoment.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOMomentBill.h"
#import "AVOMomentPhoto.h"
#import "AVOMomentNote.h"
#import "AVOUser.h"

@interface AVOMoment : AVOCommModel

@property (nonatomic) long long momentID;
@property (nonatomic) long long sdate;
@property (nonatomic) long long creator;
@property (nonatomic) int comments;
@property (nonatomic ,retain) AVOMomentBill *bill;
@property (nonatomic, retain) AVOMomentNote *note;
@property (nonatomic, retain) AVOMomentPhoto *photo;
@property (nonatomic, retain) NSString *destination;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) AVOUser *creatUser;
@property (nonatomic, retain) NSMutableArray  *commentArray,*locationArray;

@end
