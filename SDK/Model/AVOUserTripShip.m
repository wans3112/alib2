//
//  AVOUserTripShip.m
//  Avolo
//
//  Created by Zhengji Tao on 12/12/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOUserTripShip.h"
#import "LKDBHelper.h"
#import "AppPreference.h"
#import "NVInDiskKeyMananger.h"

#define KEY_ID @"ID"
#define KEY_USERID @"userID"
#define KEY_TRIPID @"tripID"
#define KEY_STATUS @"status"

@implementation AVOUserTripShip
@synthesize userID, tripID, status;
@synthesize mUser;
@synthesize consumedTotal;
@synthesize paidTotal;
@synthesize payments;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.ID = [[dict objectForKey:KEY_ID] longLongValue];
        self.userID = [[dict objectForKey:KEY_USERID] longLongValue];
        self.tripID = [[dict objectForKey:KEY_TRIPID] longLongValue];
        self.status = [[dict objectForKey:KEY_STATUS] intValue];
        
        self.payments=[NSMutableArray array];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.ID], KEY_ID, [NSNumber numberWithLongLong:self.userID], KEY_USERID, [NSNumber numberWithLongLong:self.tripID], KEY_TRIPID, [NSNumber numberWithInt:self.status], KEY_STATUS, nil];
}

+(NSDictionary *)getTableMapping
{
    //return nil
    return @{ @"ID":LKSQLInherit,
              @"userID":LKSQLInherit,
              @"tripID":LKSQLInherit,
              @"status":LKSQLInherit,
              @"consumedTotal":LKSQLInherit,
              @"paidTotal":LKSQLInherit,
              @"mUser":LKSQLUserCalculate,
              @"payments":LKSQLUserCalculate};
}

+(NSString *)getPrimaryKey
{
    return KEY_ID;
}

+(NSString *)getTableName
{
    long long userID=[[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID;
    
    NSString *mTableName=[NSString stringWithFormat:@"user_%lld_member",userID];
    return mTableName;
}

+(int)getTableVersion
{
    return 1;
}

-(id)userGetValueForModel:(LKDBProperty *)property
{
    if([property.sqlColumeName isEqualToString:@"mUser"])
    {
        [AVOUser insertToDB:self.mUser];
        return @(self.mUser.userID);
    }
    return nil;
}

-(void)userSetValueForModel:(LKDBProperty *)property value:(id)value
{
    if([property.sqlColumeName isEqualToString:@"mUser"])
    {
        self.mUser = nil;
        NSMutableArray* array  = [AVOUser searchWithWhere:[NSString stringWithFormat:@"userID = %lld",[value longLongValue]] orderBy:nil offset:0 count:1];

        if(array.count>0)
            self.mUser = [array objectAtIndex:0];
    }
}
@end
