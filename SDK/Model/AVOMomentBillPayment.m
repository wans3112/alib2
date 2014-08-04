//
//  AVOMomentBillPayment.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOMomentBillPayment.h"
#import "AppPreference.h"
#import "NVInDiskKeyMananger.h"

#define KEY_PAYMENTID @"id"
#define KEY_BILLID @"billID"
#define KEY_USERID @"userID"
#define KEY_PAID @"paid"
#define KEY_CONSUMED @"consumed"

@implementation AVOMomentBillPayment
@synthesize paymentID, billID, userID, paid, consumed;
@synthesize user;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.paymentID = [[dict objectForKey:KEY_PAYMENTID] longLongValue];
        self.billID = [[dict objectForKey:KEY_BILLID] longLongValue];
        self.userID = [[dict objectForKey:KEY_USERID] longLongValue];
        self.paid = [[dict objectForKey:KEY_PAID] doubleValue];
        self.consumed = [[dict objectForKey:KEY_CONSUMED] doubleValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.paymentID], KEY_PAYMENTID, [NSNumber numberWithLongLong:self.billID], KEY_BILLID, [NSNumber numberWithLongLong:self.userID], KEY_USERID, [NSNumber numberWithDouble:self.paid], KEY_PAID, [NSNumber numberWithDouble:self.consumed], KEY_CONSUMED, nil];
}

+(NSDictionary *)getTableMapping
{
    //return nil
    return @{@"paymentID":LKSQLInherit,
             @"billID":LKSQLInherit,
             @"userID":LKSQLInherit,
             @"paid":LKSQLInherit,
             @"consumed":LKSQLInherit,
             @"user":LKSQLUserCalculate};
}

+(NSString *)getPrimaryKey
{
    return @"paymentID";
}

+(NSString *)getTableName
{
    long long userID= [[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID;
    long long tripID=[AppPreference sharedAppPreference].currTripNode.tripID;
    NSString *mTableName=[NSString stringWithFormat:@"user_%lld_trip_%lld_payments",userID,tripID];
    return mTableName;
}

+(int)getTableVersion
{
    return 1;
}

-(id)userGetValueForModel:(LKDBProperty *)property
{
    if([property.sqlColumeName isEqualToString:@"user"])
    {
//        [AVOUser insertWhenNotExists:self.user];
        return @(self.userID);
    }
    return nil;
}

-(void)userSetValueForModel:(LKDBProperty *)property value:(id)value
{
    if([property.sqlColumeName isEqualToString:@"user"])
    {
        self.user = nil;
        NSMutableArray* array  = [AVOUser searchWithWhere:[NSString stringWithFormat:@"userID = %d",[value intValue]] orderBy:nil offset:0 count:1];
        
        if(array.count>0)
            self.user = [array objectAtIndex:0];
    }
}

@end
