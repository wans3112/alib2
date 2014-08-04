//
//  AVOAPICreateBillPaymentRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateBillPaymentRequest.h"
#import "AVOMomentBillPayment.h"

#define KEY_PAYMENTS @"payments"

@implementation AVOAPICreateBillPaymentRequest
@synthesize payments;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict) {
        self.payments = [dict objectForKey:payments];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for(NSDictionary *d in self.payments) {
            [tmp addObject:[[[AVOMomentBillPayment alloc] init] fromDictionary:d]];
        }
        self.payments = tmp;
    }
    return self;
}

-(NSDictionary *)toDictionary {
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for(AVOMomentBillPayment *pay in self.payments) {
        [ret addObject:[pay toDictionary]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:ret, KEY_PAYMENTS, nil];
}

@end
