//
//  AVOMoment.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOMoment.h"
#import "NVInDiskKeyMananger.h"
#import "AppPreference.h"
#import "AVOMomentComment.h"
#import "Constants.h"
#import "JSONKit.h"

#define KEY_MOMENTID @"id"
#define KEY_SDATE @"sdate"
#define KEY_CREATOR @"creator"
#define KEY_COMMENTS @"comments"
#define KEY_BILL @"bill"
#define KEY_NOTE @"note"
#define KEY_PHOTO @"photo"

@implementation AVOMoment
@synthesize momentID, sdate, creator, comments, bill, note, photo;
@synthesize date;
@synthesize creatUser;
@synthesize commentArray;
@synthesize destination;
@synthesize locationArray;

+(NSDictionary *)getTableMapping
{
    //return nil
    return @{@"momentID":LKSQLInherit,
             @"sdate":LKSQLInherit,
             @"creator":LKSQLInherit,
             @"comments":LKSQLInherit,
             @"bill":LKSQLUserCalculate,
             @"note":LKSQLUserCalculate,
             @"photo":LKSQLUserCalculate,
             @"creatUser":LKSQLUserCalculate,
             @"destination" : LKSQLInherit,
             @"locationArray" : LKSQLUserCalculate,
             @"date" : LKSQLInherit};
}

- (id)init{
    self = [super init];
    if(self) {
        self.bill = nil;
        self.note = nil;
        self.photo = nil;
    }
    return self;
}

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.momentID = [[dict objectForKey:KEY_MOMENTID] longLongValue];
        self.sdate = [[dict objectForKey:KEY_SDATE] longLongValue];
        
        self.creator = [[dict objectForKey:KEY_CREATOR] longLongValue];
        self.comments = [[dict objectForKey:KEY_COMMENTS] intValue];
        self.bill = [dict objectForKey:KEY_BILL] != nil ? [[[AVOMomentBill alloc] init] fromDictionary:[dict objectForKey:KEY_BILL]] : nil;
        self.note = [dict objectForKey:KEY_NOTE] != nil ? [[[AVOMomentNote alloc] init] fromDictionary:[dict objectForKey:KEY_NOTE]] : nil;
        self.photo = [dict objectForKey:KEY_PHOTO] != nil ? [[[AVOMomentPhoto alloc] init] fromDictionary:[dict objectForKey:KEY_PHOTO]] : nil;
    }
    return self;
}

-(NSDictionary *)toDictionary {
    NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.momentID], KEY_MOMENTID, [NSNumber numberWithLongLong:self.sdate], KEY_SDATE, [NSNumber numberWithLongLong:self.creator], KEY_CREATOR, [NSNumber numberWithInt:self.comments], KEY_COMMENTS, nil];
    if(self.bill != nil) {
        [tmp setValue:[self.bill toDictionary] forKey:KEY_BILL];
    } else if(self.note != nil) {
        [tmp setValue:[self.note toDictionary] forKey:KEY_NOTE];
    } else if(self.photo != nil) {
        [tmp setValue:[self.photo toDictionary] forKey:KEY_PHOTO];
    }
    return tmp;
}

+(NSString *)getPrimaryKey
{
    return @"momentID";
}

+(NSString *)getTableName
{
    long long userID= [[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID;
    long long tripID=[AppPreference sharedAppPreference].currTripNode.tripID;
    NSString *mTableName=[NSString stringWithFormat:@"user_%lld_trip_%lld_moments",userID,tripID];
//    NSLog(@"moments getTableName:%@",mTableName);
    return mTableName;
}

+(int)getTableVersion
{
    return 1;
}

-(id)userGetValueForModel:(LKDBProperty *)property
{
    if([property.sqlColumeName isEqualToString:@"creatUser"])
    {
        [AVOUser insertToDB:self.creatUser];
        return @(self.creator);
    }else if([property.sqlColumeName isEqualToString:@"bill"]){
        if (self.bill) {
            [AVOMomentBill insertToDB:self.bill];
            return @(self.bill.billID);
        }
    }else if([property.sqlColumeName isEqualToString:@"note"]){
        if (self.note) {
            [AVOMomentNote insertToDB:self.note];
            return @(self.note.noteID);
        }
    }else if([property.sqlColumeName isEqualToString:@"photo"]){
        if (self.photo) {
            [AVOMomentPhoto insertToDB:self.photo];
            return @(self.photo.photoID);
        }
    }
//    else if([property.sqlColumeName isEqualToString:@"commentArray"]){
//        for (AVOMomentComment *comment in self.commentArray) {
//            [AVOMomentComment insertWhenNotExists:comment];
//        }
//        return @(self.momentID);
//    }
    else if([property.sqlColumeName isEqualToString:@"locationArray"])
    {
        return self.destination;
    }
    return nil;
}

-(void)userSetValueForModel:(LKDBProperty *)property value:(id)value
{
    if([property.sqlColumeName isEqualToString:@"creatUser"])
    {
        self.creatUser = nil;
        NSMutableArray* array  = [AVOUser searchWithWhere:[NSString stringWithFormat:@"userID = %lld",[value longLongValue]] orderBy:nil offset:0 count:1];
        
        if(array.count>0)
//            NSLog(@"moment 从数据库获取  aovget monent:%@",self.creatUser);
            self.creatUser = [array objectAtIndex:0];
    }else if ([property.sqlColumeName isEqualToString:@"bill"]){
        self.bill = nil;
        NSMutableArray* array  = [AVOMomentBill searchWithWhere:[NSString stringWithFormat:@"billID = %lld",[value longLongValue]] orderBy:nil offset:0 count:1];
        
        if(array.count>0)
            self.bill = [array objectAtIndex:0];
    }else if ([property.sqlColumeName isEqualToString:@"note"]){
        self.note = nil;
        NSMutableArray* array  = [AVOMomentNote searchWithWhere:[NSString stringWithFormat:@"noteID = %lld",[value longLongValue]] orderBy:nil offset:0 count:1];
        
        if(array.count>0)
            self.note = [array objectAtIndex:0];
    }else if ([property.sqlColumeName isEqualToString:@"photo"]){
        self.photo = nil;
        NSMutableArray* array  = [AVOMomentPhoto searchWithWhere:[NSString stringWithFormat:@"photoID = %lld",[value longLongValue]] orderBy:nil offset:0 count:1];
        
        if(array.count>0)
            self.photo = [array objectAtIndex:0];
    }
//    else if ([property.sqlColumeName isEqualToString:@"commentArray"]){
//        self.commentArray = nil;
//        NSString *where=[NSString stringWithFormat:@"momentID = %lld",[value longLongValue]];
//        NSLog(@"where >> :%@",where);
//        NSMutableArray* array  = [AVOMomentComment searchWithWhere:where orderBy:nil offset:0 count:GET_COMENTS];
//        
//        if(array.count>0)
//            self.commentArray = array;
//        NSLog(@"从数据库获取 commentArray count:%d", self.commentArray.count);
//    }
    else if([property.sqlColumeName isEqualToString:@"locationArray"])
    {
        self.locationArray=(NSMutableArray *)[value objectFromJSONString];
    }
}

@end
