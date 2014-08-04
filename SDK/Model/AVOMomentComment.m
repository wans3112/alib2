//
//  AVOMomentComment.m
//  Avolo
//
//  Created by Zhengji Tao on 12/10/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOMomentComment.h"
#import "AppPreference.h"
#import "LKDBHelper.h"
#import "NVInDiskKeyMananger.h"

#define KEY_ID @"ID"
#define KEY_POSTER_ID @"posterID"
#define KEY_TEXT @"text"
#define KEY_DATE @"date"

@implementation AVOMomentComment
@synthesize ID, posterID, text, date;
@synthesize posterUser;
@synthesize postDate;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.ID = [[dict objectForKey:KEY_ID] longLongValue];
        self.posterID = [[dict objectForKey:KEY_POSTER_ID] longLongValue];
        self.text = [dict objectForKey:KEY_TEXT];
        self.date = [[dict objectForKey:KEY_DATE] longLongValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.ID], KEY_ID, [NSNumber numberWithLongLong:self.posterID], KEY_POSTER_ID, self.text, KEY_TEXT, [NSNumber numberWithLongLong:self.date], KEY_DATE, nil];
}

+(NSDictionary *)getTableMapping
{
    //return nil
    return @{@"ID":LKSQLInherit,
             @"posterID":LKSQLInherit,
             @"text":LKSQLInherit,
             @"date":LKSQLInherit,
             @"posterUser":LKSQLUserCalculate,
             @"postDate":LKSQLUserCalculate};
}

+(NSString *)getPrimaryKey
{
    return @"ID";
}

+(NSString *)getTableName
{
    long long userID= [[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID;
    long long tripID=[AppPreference sharedAppPreference].currTripNode.tripID;
    long long momentID=[AppPreference sharedAppPreference].currMoment.momentID;
    NSString *mTableName=[NSString stringWithFormat:@"user_%lld_trip_%lld_moment_%lld",userID,tripID,momentID];
//    NSLog(@"moments getTableName:%@",mTableName);
    return mTableName;
}

-(id)userGetValueForModel:(LKDBProperty *)property
{
    if([property.sqlColumeName isEqualToString:@"posterUser"])
    {
//        [AVOUser insertToDB:self.creatUser];
        return @(self.posterID);
    }else if([property.sqlColumeName isEqualToString:@"postDate"]){
        
        return @(self.date);
    }
    return nil;
}

-(void)userSetValueForModel:(LKDBProperty *)property value:(id)value
{
    if([property.sqlColumeName isEqualToString:@"posterUser"])
    {
        self.posterUser = nil;
        NSMutableArray* array  = [AVOUser searchWithWhere:[NSString stringWithFormat:@"userID = %lld",[value longLongValue]] orderBy:nil offset:0 count:1];
        if(array.count>0)
            self.posterUser = [array objectAtIndex:0];
    }else if ([property.sqlColumeName isEqualToString:@"postDate"]){
        self.postDate = [NSDate dateWithTimeIntervalSince1970:([value longLongValue]/TRIPSTIMES)];
    }
}

+(int)getTableVersion
{
    return 1;
}

@end
