//
//  AVOMomentNote.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOMomentNote.h"
#import "AppPreference.h"
#import "NVInDiskKeyMananger.h"

#define KEY_NOTEID @"id"
#define KEY_TEXT @"text"

@implementation AVOMomentNote
@synthesize noteID, text;

+(NSDictionary *)getTableMapping
{
    //return nil
    return @{@"noteID":LKSQLInherit,
             @"text":LKSQLInherit,};
}

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.noteID = [[dict objectForKey:KEY_NOTEID] longLongValue];
        self.text = [dict objectForKey:KEY_TEXT];
    }
    return self;
}

-(NSDictionary *)toDictionary{
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.noteID], KEY_NOTEID, self.text, KEY_TEXT, nil];
}

+(NSString *)getPrimaryKey
{
    return @"noteID";
}

+(NSString *)getTableName
{
    long long userID= [[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID;
    long long tripID=[AppPreference sharedAppPreference].currTripNode.tripID;
    
    NSString *mTableName=[NSString stringWithFormat:@"user_%lld_trip_%lld_notes",userID,tripID];
//    NSLog(@"AVOMomentNote getTableName:%@",mTableName);
    return mTableName;
}

+(int)getTableVersion
{
    return 1;
}

@end
