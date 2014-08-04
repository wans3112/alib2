//
//  AVOMomentBillDetail.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOMomentBill.h"

@interface AVOMomentBillDetail : AVOCommModel

@property (nonatomic, retain) AVOMomentBill *summary;
@property (nonatomic) long long imageID;
@property (nonatomic, retain) NSString *note;

@end
