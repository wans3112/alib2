//
//  NVBasicClient.m
//  NVSDK2
//
//  Created by Zhengji Tao on 11/2/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import "NVBasicClient.h"
#import "Unirest.h"
#import "Base64.h"
#import "NVPlainHttpClient.h"
#import "NVIOTUserAuthFailedException.h"
#import "AVOAPIConstants.h"
#import "AVOAPICommonErrorResponse.h"
#import "AVOAPICreateLocalUserTokenRequest.h"
#import "AVOAPICreateLocalUserTokenResponse.h"

@implementation NVBasicClient
@synthesize keyManager;
@synthesize userCredential, userToken;

- (instancetype) initWithKeyManager:(id<AVOKeyManager>)km{
    self = [super init];
    if(self) {
        self.keyManager = km;
        [self updateLocalKeys];
    }
    
    return self;
}

- (void) updateLocalKeys {
    self.userCredential = [self.keyManager loadUserCredential];
    self.userToken = [self.keyManager loadToken];
}

- (void) assertUserCredential {
    if(self.userCredential != nil) {
        if(self.userCredential.email != nil && [self.userCredential.email length] > 0) {
            if(self.userCredential.passHash != nil && [self.userCredential.passHash length] > 0) {
                return ;
            }
        }
    }
    
    @throw [[NVIOTUserAuthFailedException alloc] init];
}

- (void) assertUserToken {
    if(self.userToken != nil) {
        if(self.userToken.token != nil && [self.userToken.token length] > 0) {
            if(self.userToken.expires > [[NSDate date] timeIntervalSince1970] * 1000) {
                return;
            }
        }
    }
    
    [self.keyManager removeAllToken];
    
    [self assertUserCredential];
    
    @try {
        self.userToken = [self userLogin];
        if(self.userToken != nil) {
            [self.keyManager storeToken:self.userToken];
            return;
        }
    }
    @catch (NVIOTServiceException *exception) {
        if(exception.errCode == nvHttpStatus_CLIENT_ERROR_FORBIDDEN) {
            @throw [[NVIOTUserAuthFailedException alloc] init];
        } else {
            @throw [[NVIOTClientException alloc] init];
        }
    }
    
    @throw [[NVIOTUserAuthFailedException alloc] init];
}

- (void) assertResponse:(NSObject *) response {
    if(response == nil) {
        @throw [[NVIOTClientException alloc] initWithName:@"Client Exception" reason:@"Response is nil." userInfo:nil];
    }
}

- (void) handleErrorResponse:(UNIHTTPJsonResponse *) response {
    if(response.code == nvHttpStatus_CLIENT_ERROR_UNAUTHORIZED) {
        //token is invalid
        [self.keyManager removeAllToken];
    }
    AVOAPICommonErrorResponse *res = [[AVOAPICommonErrorResponse alloc] init];
    [res fromDictionary:[response.body JSONObject]];
    @throw [[NVIOTServiceException alloc] initWithErrCode:res.errCode];
}

- (AVOUserToken *) userLogin {
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPOST];
    [httpClient authWithToken:[Base64 base64String:@"111111"]];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_LOCAL_USER_TOKEN_STR);
    
    AVOAPICreateLocalUserTokenRequest *body = [[AVOAPICreateLocalUserTokenRequest alloc] init];
    body.localcre = self.userCredential;
    
    UNIHTTPJsonResponse* response = [[UNIRest postEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[body toDictionary] options:0 error:nil]];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        AVOAPICreateLocalUserTokenResponse *ret = [[[AVOAPICreateLocalUserTokenResponse alloc] init] fromDictionary:[response.body JSONObject]];
        NSLog(@"Token:%@, %lld", ret.token.token, ret.token.expires);
        return ret.token;
    } else if (response.code == nvHttpStatus_CLIENT_ERROR_UNAUTHORIZED) {
        [self.keyManager removeUserCredential];
        [self.keyManager removeAllToken];
        @throw [[NVIOTUserAuthFailedException alloc] initWithErrCode:response.code
                 ];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

/// imp

-(AVOAPICreateLocalUserResponse *)createLocalUser:(AVOAPICreateLocalUserRequest *)req {
//    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPOST];
    [httpClient authWithToken:[Base64 base64String:@"111111"]];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_LOCAL_USER_STR);
    
    UNIHTTPJsonResponse* response = [[UNIRest postEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];

    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        AVOAPICreateLocalUserResponse *ret = [[[AVOAPICreateLocalUserResponse alloc] init] fromDictionary:[response.body JSONObject]];
        if(ret!=nil) {
            self.userCredential = req.localcre;
            [self.keyManager storeUserCredential:self.userCredential];
        }
        return ret;
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(BOOL)updateLocalCredential:(AVOAPIUpdateLocalUserRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPUT];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_LOCAL_USER_STR);
    
    UNIHTTPJsonResponse* response = [[UNIRest putEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_NO_CONTENT ) {
        return YES;
    }
    
    [self handleErrorResponse:response];
    return NO;
}

-(BOOL)updateUser:(long long) userID and:(AVOAPIUpdateUserRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPUT];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_USER_STR(userID));
    
    UNIHTTPJsonResponse* response = [[UNIRest putEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_NO_CONTENT ) {
        return YES;
    }
    
    [self handleErrorResponse:response];
    return NO;
}

-(AVOAPIGetUserResponse *)getUser:(long long) userID {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_USER_STR(userID));
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        AVOAPIGetUserResponse *ret = [[[AVOAPIGetUserResponse alloc] init] fromDictionary:[response.body JSONObject]];
        return ret;
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPICreateImageResponse *)updateAvatar:(NSURL *)filepath {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPUT];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_IMAGES_AVATAR_STR);
    [httpClient addParamer:@"file" andValue:filepath];
    
    UNIHTTPJsonResponse* response = [[UNIRest put:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPICreateImageResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPICreateImageResponse *)updatePhoto:(NSURL *)filepath {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPUT];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_IMAGES_PHOTO_STR);
    [httpClient addParamer:@"file" andValue:filepath];
    
    UNIHTTPJsonResponse* response = [[UNIRest put:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPICreateImageResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPICreateTripSummaryResponse *)createTrip:(AVOAPICreateTripSummaryRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPOST];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_TRIPS_STR);
    
    UNIHTTPJsonResponse* response = [[UNIRest postEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPICreateTripSummaryResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPIGetTripsResponse *)getTrips:(long long)startID and:(int)limit {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_TRIPS_STR);
    httpClient.url = [NSString stringWithFormat:@"%@?start=%lld&limit=%d",httpClient.url, startID, limit];
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPIGetTripsResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(BOOL)updateTrip:(long long) tripID and:(AVOAPIUpdateTripSummaryRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPUT];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_TRIP_STR(tripID));
    
    UNIHTTPJsonResponse* response = [[UNIRest putEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_NO_CONTENT ) {
        return YES;
    }
    
    [self handleErrorResponse:response];
    return NO;
}

-(AVOAPIGetTripResponse *)getTrip:(long long)tripID {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_TRIP_STR(tripID));
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPIGetTripResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPICreateMomentResponse *)createMoment:(long long) tripID and: (AVOAPICreateMomentRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPOST];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_MOMENTS_STR(tripID));
    
    UNIHTTPJsonResponse* response = [[UNIRest postEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPICreateMomentResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPIGetMomentsResponse *)getMoments:(long long)tripID andStartID:(long long)startID andLimit:(int)limit{
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_MOMENTS_STR(tripID));
    httpClient.url = [NSString stringWithFormat:@"%@?start=%lld&limit=%d",httpClient.url, startID, limit];
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPIGetMomentsResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(BOOL)updateMomentBill:(long long)billID and:(AVOAPIUpdateMomentBillRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPUT];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_MOMENT_BILL_STR(billID));
    
    UNIHTTPJsonResponse* response = [[UNIRest putEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_NO_CONTENT ) {
        return YES;
    }
    
    [self handleErrorResponse:response];
    return NO;
}

-(AVOAPIGetBillDetailResponse *)getMomentBill:(long long)billID {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_MOMENT_BILL_STR(billID));
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPIGetBillDetailResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(BOOL)updateBillPayment:(long long)billID and:(AVOAPICreateBillPaymentRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPUT];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_MOMENT_BILL_PAYMENTS_STR(billID));
    
    UNIHTTPJsonResponse* response = [[UNIRest putEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_NO_CONTENT ) {
        return YES;
    }
    
    [self handleErrorResponse:response];
    return NO;
}

-(AVOAPIGetBillPaymentsResponse *)getBillPayments:(long long)billID {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_MOMENT_BILL_PAYMENTS_STR(billID));
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPIGetBillPaymentsResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPICreateMomentCommentResponse *)createMomentComment:(long long)momentID and:(AVOAPICreateMomentCommentRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPOST];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_MOMENT_COMMENTS_STR(momentID));
    
    UNIHTTPJsonResponse* response = [[UNIRest postEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPICreateMomentCommentResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPIGetMomentCommentsResponse *)getMomentComments:(long long)momentID and:(long long)startID and:(int)limit {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_MOMENT_COMMENTS_STR(momentID));
    httpClient.url = [NSString stringWithFormat:@"%@?start=%lld&limit=%d",httpClient.url, startID, limit];
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPIGetMomentCommentsResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(BOOL)updateTripMemberShip:(long long)tripID andShip:(AVOAPIUpdateTripMemberRequest *)req {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpPUT];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_TRIP_MEMBERS_STR(tripID));
    
    UNIHTTPJsonResponse* response = [[UNIRest putEntity:^(UNIBodyRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:[req toDictionary] options:0 error:nil]];
    }] asJson];
    
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_NO_CONTENT ) {
        return YES;
    }
    
    [self handleErrorResponse:response];
    return NO;
}

-(AVOAPIGetTripMembersResponse *)getTripMembers:(long long)tripID {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_TRIP_MEMBERS_STR(tripID));
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPIGetTripMembersResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

-(AVOAPIGetImageResponse *)getImage:(long long)imageID {
    [self assertUserToken];
    
    NVPlainHttpClient *httpClient = [[NVPlainHttpClient alloc] initWithHttpMethod:nvHttpGET];
    [httpClient authWithToken:self.userToken.token];
    httpClient.url = AVOAPI_URL_STR(AVOAPI_PATH_IMAGE_STR(imageID));
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:httpClient.url];
        [request setHeaders:httpClient.headers];
        [request setParameters:httpClient.paramers];
    }] asJson];
    
    [self assertResponse:response];
    
    if (response.code == nvHttpStatus_SUCCESS_OK ) {
        return [[[AVOAPIGetImageResponse alloc] init] fromDictionary:[response.body JSONObject]];
    }
    
    [self handleErrorResponse:response];
    return nil;
}

/// imp end

///
@end
