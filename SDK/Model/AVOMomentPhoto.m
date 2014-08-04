//
//  AVOMomentPhoto.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOMomentPhoto.h"
#import "AppPreference.h"
#import "NVInDiskKeyMananger.h"

#define KEY_PHOTOID @"id"
#define KEY_IMAGEID @"imageID"
#define KEY_IMAGEURL @"imageUrl"
#define KEY_NOTE @"note"

@implementation AVOMomentPhoto
@synthesize photoID, imageID, imageUrl, note;
@synthesize photoImage;

+(NSDictionary *)getTableMapping
{
    //return nil
    return @{@"photoID":LKSQLInherit,
             @"imageID":LKSQLInherit,
             @"imageUrl":LKSQLInherit,
             @"note":LKSQLInherit,
             @"photoImage":LKSQLUserCalculate};
}

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.photoID = [[dict objectForKey:KEY_PHOTOID] longLongValue];
        self.imageID = [[dict objectForKey:KEY_IMAGEID] longLongValue];
        self.imageUrl = [dict objectForKey:KEY_IMAGEURL];
        self.note = [dict objectForKey:KEY_NOTE];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.photoID], KEY_PHOTOID, [NSNumber numberWithLongLong:self.imageID], KEY_IMAGEID, self.imageUrl, KEY_IMAGEURL, self.note, KEY_NOTE, nil];
}

+(NSString *)getPrimaryKey
{
    return @"photoID";
}

+(NSString *)getTableName
{
    long long userID= [[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID;
    long long tripID=[AppPreference sharedAppPreference].currTripNode.tripID;
    
    NSString *mTableName=[NSString stringWithFormat:@"user_%lld_trip_%lld_photoes",userID,tripID];
//    NSLog(@"AVOMomentPhoto getTableName:%@",mTableName);
    return mTableName;
}

+(int)getTableVersion
{
    return 1;
}
@end
