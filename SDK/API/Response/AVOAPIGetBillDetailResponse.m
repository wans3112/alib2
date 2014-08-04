//
//  AVOAPIGetBillDetailResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIGetBillDetailResponse.h"

#define KEY_BILLDETAIL @"billDetail"

@implementation AVOAPIGetBillDetailResponse
@synthesize billDetail;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.billDetail = [[[AVOMomentBillDetail alloc] init] fromDictionary:[dict objectForKey:KEY_BILLDETAIL]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.billDetail toDictionary], KEY_BILLDETAIL, nil];
}

@end
