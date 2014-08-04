//
//  AVOUser.m
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOUser.h"
#import "SDImageCache.h"
#import "NVInDiskKeyMananger.h"
#import "LKDBUtils.h"
#import "LKDBHelper.h"
#import "NVBasicClient.h"
#import "NVInDiskKeyMananger.h"
#import "NVIOTServiceException.h"
#import "NVIOTUserAuthFailedException.h"
#import "NVIOTClientException.h"

#define KEY_LASTNAME @"lastname"
#define KEY_FIRSTNAME @"firstname"
#define KEY_EMAIL @"email"
#define KEY_DESC @"description"
#define KEY_IMAGEID @"imageID"


@implementation AVOUser
@synthesize lastname, firstname, email, desc, imageID;
@synthesize userID;
@synthesize headImage;
@synthesize fullName;
@synthesize imageUrl;

+(NSDictionary *)getTableMapping
{
    
    return @{@"userID":LKSQLInherit,
             @"lastname":LKSQLInherit,
             @"firstname":LKSQLInherit,
             @"email":LKSQLInherit,
             @"desc":LKSQLInherit,
             @"imageID":LKSQLInherit,
             @"headImage":LKSQLInherit,
             @"fullName":LKSQLInherit,
             @"imageUrl" : LKSQLInherit};
}

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.lastname = [dict objectForKey:KEY_LASTNAME];
        self.firstname = [dict objectForKey:KEY_FIRSTNAME];
        self.email = [dict objectForKey:KEY_EMAIL];
        self.desc = [dict objectForKey:KEY_DESC];
        self.imageID = [[dict objectForKey:KEY_IMAGEID] longLongValue];
        
        self.imageUrl=nil;
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.lastname, KEY_LASTNAME, self.firstname, KEY_FIRSTNAME, self.email, KEY_EMAIL, self.desc, KEY_DESC, [NSNumber numberWithLongLong:self.imageID], KEY_IMAGEID, nil];
}

+(NSString *)getPrimaryKey
{
    return @"userID";
}

+(NSString *)getTableName
{
    return [NSString stringWithFormat:@"user_%lld", [[NVInDiskKeyMananger sharedNVInDiskKeyMananger] loadToken].userID];
}

+(int)getTableVersion
{
    return 1;
}

//-(id)userGetValueForModel:(LKDBProperty *)property
//{
//    if([property.sqlColumeName isEqualToString:@"fullName"])
//    {
//        return @(self.userID);
//    }
//    return nil;
//}
//
//-(void)userSetValueForModel:(LKDBProperty *)property value:(id)value
//{
//    if([property.sqlColumeName isEqualToString:@"fullName"])
//    {
//        self.fullName=[NSString stringWithFormat:@"%@ %@",self.firstname,self.lastname];
//    }
//}

//- (NSString *)imageUrl{
//    if (!imageUrl || imageUrl.length == 0) {
//        [self performSelectorInBackground:@selector(doGetUserImageUrl) withObject:nil];
//    }
//    return imageUrl;
//}
//
//- (void) doGetUserImageUrl{
//    NSString *errorInfo=nil;
//    
//    @try {
//        NVBasicClient *client=[[[NVBasicClient alloc]initWithKeyManager:[NVInDiskKeyMananger sharedNVInDiskKeyMananger]]autorelease];
//        
//        AVOAPIGetImageResponse *imageResponse=[client getImage:imageID];
//        imageUrl=AVOAPI_URL_DOWNLOAD_STR(imageResponse.image.url);
//        NSLog(@"self.imageUrl 图片地址为空------》》but 下载成功：%@",imageUrl);
//    }
//    @catch (NVIOTUserAuthFailedException *exception) {
//        MyLog(@"UserAuthFailed err,%@", [exception description]);
//        errorInfo=[exception description];
//    }@catch (NVIOTServiceException *exception) {
//        MyLog(@"service err,%@", [exception description]);
//        errorInfo=[exception description];
//    }@catch (NVIOTClientException *exception) {
//        MyLog(@"client err,%@", [exception description]);
//        errorInfo=[exception description];
//    }@finally {
//    }
//}

@end
