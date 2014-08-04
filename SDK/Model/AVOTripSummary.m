//
//  AVOTripSummary.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOTripSummary.h"
#import "JSONKit.h"
#import "LKDBHelper.h"
#import "NVInDiskKeyMananger.h"
#import "TimeLineNode.h"
#import "NSDate+Helper.h"
#import "TLExpenseNode.h"
#import "TLImageNode.h"
#import "TLNoteNote.h"
#import "JSONKit.h"
#import "Constants.h"
#import "AVOUserTripShip.h"
#import "AppPreference.h"

#define KEY_TRIPID @"ID"
#define KEY_TITLE @"title"
#define KEY_SDATE @"sdate"
#define KEY_DESTINATION @"destination"
#define KEY_BANNERID @"bannerID"
#define KEY_INVITECODE @"inviteCode"
#define KEY_MEMBERS @"members"
#define KEY_STATUS @"status"

@implementation AVOTripSummary
@synthesize tripID, title, sdate, destination, bannerID, inviteCode, members, status;
@synthesize personArray,locationArray,momentArray;
@synthesize bannerImage;
@synthesize bannerUrl;
@synthesize date;

- (id)init{
    
    self=[super init];
    if (self) {
      
        self.momentArray=[NSMutableArray array];
        self.personArray=[NSMutableArray array];
        self.locationArray=[NSMutableArray array];
    }
    return self;
}

- (id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.tripID = [[dict objectForKey:KEY_TRIPID] longLongValue];
        self.title = [dict objectForKey:KEY_TITLE];
        self.sdate = [[dict objectForKey:KEY_SDATE] longLongValue];
        self.destination = [dict objectForKey:KEY_DESTINATION];
        self.bannerID = [[dict objectForKey:KEY_BANNERID] longLongValue];
        self.inviteCode = [dict objectForKey:KEY_INVITECODE];
        self.members = [[dict objectForKey:KEY_MEMBERS] intValue];
        self.status = [[dict objectForKey:KEY_STATUS] intValue];
        
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.tripID], KEY_TRIPID, self.title, KEY_TITLE, [NSNumber numberWithLongLong:self.sdate], KEY_SDATE, self.destination, KEY_DESTINATION, [NSNumber numberWithLongLong:self.bannerID], KEY_BANNERID, self.inviteCode, KEY_INVITECODE, [NSNumber numberWithInt:self.members], KEY_MEMBERS, [NSNumber numberWithInt:self.status], KEY_STATUS, nil];
}

+(NSDictionary *)getTableMapping
{
    //return nil
    return @{@"tripID":LKSQLInherit,
             @"title":LKSQLInherit,
             @"sdate":LKSQLInherit,
             @"date":LKSQLInherit,
             @"destination":LKSQLInherit,
             @"bannerID":LKSQLInherit,
             @"inviteCode":LKSQLInherit,
             @"members":LKSQLInherit,
             @"status":LKSQLInherit,
             @"bannerImage":LKSQLInherit,
             @"bannerUrl":LKSQLInherit,
             @"personArray":LKSQLUserCalculate,
             @"locationArray":LKSQLUserCalculate};
}

+(NSString *)getPrimaryKey
{
    return @"tripID";
}

+(NSString *)getTableName
{
    return [NSString stringWithFormat:@"user_trip_%lld", [[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID];
}

+(int)getTableVersion
{
    return 1;
}

-(id)userGetValueForModel:(LKDBProperty *)property
{
    if([property.sqlColumeName isEqualToString:@"personArray"])
    {
        for (AVOUserTripShip *tripShip in self.personArray) {
            if ([AVOUserTripShip insertWhenNotExists:tripShip]) {
                [AVOUserTripShip updateToDB:tripShip where:nil];
            }
        }
        return @(self.tripID);
    }else if([property.sqlColumeName isEqualToString:@"locationArray"])
    {
        return self.destination;
    }
//    else if([property.sqlColumeName isEqualToString:@"momentArray"])
//    {
//        for (AVOMoment *moment in self.momentArray) {
//            if ([AVOMoment insertWhenNotExists:moment]) {
//                [AVOMoment updateToDB:moment where:nil];
//            }
//        }
//        return @(self.tripID);
//    }
    return nil;
}

-(void)userSetValueForModel:(LKDBProperty *)property value:(id)value
{
    if([property.sqlColumeName isEqualToString:@"personArray"])
    {
        self.personArray = nil;
        NSString *where=[NSString stringWithFormat:@"tripID = %lld",[value longLongValue]];
        NSMutableArray* array  = [AVOUserTripShip searchWithWhere:where orderBy:nil offset:0 count:20];
        
        if(array.count>0)
            self.personArray = array;
    }else if([property.sqlColumeName isEqualToString:@"locationArray"])
    {
        self.locationArray=(NSMutableArray *)[value objectFromJSONString];
    }
//    else if([property.sqlColumeName isEqualToString:@"momentArray"])
//    {
//        self.momentArray = nil;
//        NSMutableArray* array  = [AVOMoment searchWithWhere:nil orderBy:nil offset:0 count:GET_MOMENTS];
//        
//        if(array.count>0)
//            self.momentArray = array;
//    }
}


@end
