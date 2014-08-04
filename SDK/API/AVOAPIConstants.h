//
//  AVOAPIConstants.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AVOAPI_URL_STR(A) ([NSString stringWithFormat:@"http://api.avolo.ramytech.com/api%@", A])
#define AVOAPI_URL_DOWNLOAD_STR(A) ([NSString stringWithFormat:@"http://download.avolo.ramytech.com%@", A])

#define AVOAPI_PATH_USER_STR(A) ([NSString stringWithFormat:@"/user/%lld", A])
#define AVOAPI_PATH_LOCAL_USER_STR @"/localuser"
#define AVOAPI_PATH_LOCAL_USER_TOKEN_STR @"/localuser/token"
#define AVOAPI_PATH_TRIPS_STR @"/trips"
#define AVOAPI_PATH_TRIP_STR(A) ([NSString stringWithFormat:@"/trip/%lld", A])
#define AVOAPI_PATH_IMAGES_AVATAR_STR @"/images/avatar"
#define AVOAPI_PATH_IMAGES_PHOTO_STR @"/images/photo"
#define AVOAPI_PATH_IMAGE_STR(A) ([NSString stringWithFormat:@"/image/%lld", A])
#define AVOAPI_PATH_MOMENTS_STR(A) ([NSString stringWithFormat:@"/trip/%lld/moments", A])
#define AVOAPI_PATH_MOMENT_BILL_STR(A) ([NSString stringWithFormat:@"/bill/%lld", A])
#define AVOAPI_PATH_MOMENT_BILL_PAYMENTS_STR(A) ([NSString stringWithFormat:@"/bill/%lld/payments", A])
#define AVOAPI_PATH_MOMENT_COMMENTS_STR(A) ([NSString stringWithFormat:@"/moment/%lld/comments", A])
#define AVOAPI_PATH_TRIP_MEMBERS_STR(A) ([NSString stringWithFormat:@"/trip/%lld/members", A])



@interface AVOAPIConstants : NSObject

@end
