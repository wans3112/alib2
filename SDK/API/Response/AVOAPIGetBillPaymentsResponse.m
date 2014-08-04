//
//  AVOAPIGetBillPaymentsResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPIGetBillPaymentsResponse.h"
#import "AVOMomentBillPayment.h"

#define KEY_PAYMENTS @"payments"

@implementation AVOAPIGetBillPaymentsResponse
@synthesize payments;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.payments = [dict objectForKey:KEY_PAYMENTS];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for(NSDictionary *d in self.payments) {
            [tmp addObject:[[[AVOMomentBillPayment alloc] init] fromDictionary:d]];
        }
        self.payments = tmp;
    }
    return self;
}

-(NSDictionary *)toDictionary {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for(AVOMomentBillPayment *payment in self.payments) {
        [tmp addObject:[payment toDictionary]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:tmp, KEY_PAYMENTS, nil];
}

@end
