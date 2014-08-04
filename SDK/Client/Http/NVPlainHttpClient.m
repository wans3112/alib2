//
//  NVPlainHttpClient.m
//  NVSDK2
//
//  Created by Zhengji Tao on 11/5/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import "NVPlainHttpClient.h"
#import "Base64.h"

@implementation NVPlainHttpClient
@synthesize url, headers, paramers, body;

- (instancetype) initWithHttpMethod:(enum NVHttpMethod)method {
    self = [super init];
    if(self) {
        self.headers = [[NSMutableDictionary alloc] init];
        self.paramers = [[NSMutableDictionary alloc] init];
        switch (method) {
            case nvHttpGET:
                [self.headers setValue:NVHEADER_ACCEPT_JSON_VALUE forKey:NVHEADER_ACCEPT_NAME];
                break;
            case nvHttpPOST:
                [self.headers setValue:NVHEADER_CONTENT_TYPE_JSON_VALUE forKey:NVHEADER_CONTENT_TYPE_NAME];
                break;
            case nvHttpPUT:
                [self.headers setValue:NVHEADER_CONTENT_TYPE_JSON_VALUE forKey:NVHEADER_CONTENT_TYPE_NAME];
                break;
            case nvHttpDELETE:
                [self.headers setValue:NVHEADER_CONTENT_TYPE_JSON_VALUE forKey:NVHEADER_CONTENT_TYPE_NAME];
                break;
            default:
                break;
        }
    }
    
    return self;
}

- (void) addHeader:(NSString *)name andValue:(NSString *)value {
    [self.headers setValue:value forKey:name];
}

- (void) addParamer:(NSString *)name andValue:(NSObject *)value {
    [self.paramers setValue:value forKey:name];
}

- (void) authWithToken:(NSString *)token {
    [self.headers setValue:token forKey:NVHEADER_TOKEN_NAME];
}



@end
