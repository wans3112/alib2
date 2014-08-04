//
//  AVOAPIGetBillDetailResponse.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOMomentBillDetail.h"

@interface AVOAPIGetBillDetailResponse : AVOCommModel

@property (nonatomic, retain) AVOMomentBillDetail *billDetail;

@end
