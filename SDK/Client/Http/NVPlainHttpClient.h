//
//  NVPlainHttpClient.h
//  NVSDK2
//
//  Created by Zhengji Tao on 11/5/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVHttpConstans.h"

@interface NVPlainHttpClient : NSObject

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSMutableDictionary *headers;
@property (nonatomic, retain) NSMutableDictionary *paramers;
@property (nonatomic, retain) NSObject *body;


- (instancetype) initWithHttpMethod:(enum NVHttpMethod) method;
- (void) authWithToken:(NSString *) token;

- (void) addHeader:(NSString *) name andValue:(NSString *) value;
- (void) addParamer:(NSString *) name andValue:(NSObject *) value;

@end
