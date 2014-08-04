//
//  AVOMomentBill.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOMomentBill.h"
#import "AppPreference.h"
#import "NVInDiskKeyMananger.h"

#define KEY_BILLID @"id"
#define KEY_AMOUT @"amount"
#define KEY_CURRENCY @"currency"
#define KEY_CATEGORY @"category"
#define KEY_DATE @"date"

@implementation AVOMomentBill
@synthesize billID, amout, currency, category;
@synthesize sdate,capImage;
@synthesize node;
@synthesize date;
@synthesize paid;
@synthesize capUrl;

+(NSDictionary *)getTableMapping
{
    //return nil
    return @{@"billID":LKSQLInherit,
             @"amout":LKSQLInherit,
             @"currency":LKSQLInherit,
             @"category":LKSQLInherit,
             @"sdate":LKSQLInherit,
             @"date":LKSQLInherit,
             @"capImage":LKSQLInherit,
             @"node":LKSQLInherit,
             @"capUrl":LKSQLInherit,
             @"paid":LKSQLInherit};
}

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.billID = [[dict objectForKey:KEY_BILLID] longLongValue];
        self.amout = [[dict objectForKey:KEY_AMOUT] doubleValue];
        self.currency = [[dict objectForKey:KEY_CURRENCY] intValue];
        self.category = [dict objectForKey:KEY_CATEGORY];
        self.date = [[dict objectForKey:KEY_DATE] longLongValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.billID], KEY_BILLID, [NSNumber numberWithDouble:self.amout], KEY_AMOUT, [NSNumber numberWithInt:self.currency], KEY_CURRENCY, self.category, KEY_CATEGORY, [NSNumber numberWithLongLong:self.date], KEY_DATE, nil];
}

+(NSString *)getPrimaryKey
{
    return @"billID";
}

+(NSString *)getTableName
{
    long long userID= [[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID;
    long long tripID=[AppPreference sharedAppPreference].currTripNode.tripID;

    NSString *mTableName=[NSString stringWithFormat:@"user_%lld_trip_%lld_bills",userID,tripID];
//    NSLog(@"AVOMomentBill getTableName:%@",mTableName);
    return mTableName;
}

+(int)getTableVersion
{
    return 1;
}

@end
