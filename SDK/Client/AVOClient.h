//
//  AVOClient.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVOAPICreateLocalUserRequest.h"
#import "AVOAPIUpdateLocalUserRequest.h"
#import "AVOAPIUpdateUserRequest.h"
#import "AVOAPIGetUserResponse.h"
#import "AVOAPICreateImageResponse.h"
#import "AVOAPICreateTripSummaryRequest.h"
#import "AVOAPICreateTripSummaryResponse.h"
#import "AVOAPIGetTripsResponse.h"
#import "AVOAPIUpdateTripSummaryRequest.h"
#import "AVOAPIGetTripResponse.h"
#import "AVOAPICreateMomentRequest.h"
#import "AVOAPICreateMomentResponse.h"
#import "AVOAPIUpdateMomentBillRequest.h"
#import "AVOAPIGetBillDetailResponse.h"
#import "AVOAPICreateBillPaymentRequest.h"
#import "AVOAPIGetMomentsResponse.h"
#import "AVOAPIGetBillPaymentsResponse.h"
#import "AVOAPICreateMomentCommentRequest.h"
#import "AVOAPICreateMomentCommentResponse.h"
#import "AVOAPIGetMomentCommentsResponse.h"
#import "AVOAPICreateLocalUserResponse.h"
#import "AVOAPIUpdateTripMemberRequest.h"
#import "AVOAPIGetTripMembersResponse.h"
#import "AVOAPIGetImageResponse.h"

@protocol AVOClient <NSObject>

- (AVOAPICreateLocalUserResponse *) createLocalUser:(AVOAPICreateLocalUserRequest *) req;

- (BOOL) updateLocalCredential:(AVOAPIUpdateLocalUserRequest *) req;

- (BOOL) updateUser:(long long) userID and:(AVOAPIUpdateUserRequest *) req;

- (AVOAPIGetUserResponse *) getUser:(long long) userID;

- (AVOAPICreateImageResponse *) updateAvatar:(NSURL *) filepath;

- (AVOAPICreateImageResponse *) updatePhoto:(NSURL *) filepath;

- (AVOAPICreateTripSummaryResponse *) createTrip:(AVOAPICreateTripSummaryRequest *) req;

- (AVOAPIGetTripsResponse *) getTrips:(long long) startID and:(int) limit;

- (BOOL) updateTrip:(long long) tripID and:(AVOAPIUpdateTripSummaryRequest *) req;

- (AVOAPIGetTripResponse *) getTrip:(long long) tripID;

- (AVOAPICreateMomentResponse *) createMoment:(long long) tripID and: (AVOAPICreateMomentRequest *) req;

- (AVOAPIGetMomentsResponse *) getMoments:(long long) tripID andStartID:(long long) startID andLimit:(int) limit;

- (BOOL) updateMomentBill:(long long) billID and:(AVOAPIUpdateMomentBillRequest *) req;

- (AVOAPIGetBillDetailResponse *) getMomentBill:(long long) billID;

- (BOOL) updateBillPayment:(long long) billID and:(AVOAPICreateBillPaymentRequest *) req;

- (AVOAPIGetBillPaymentsResponse *) getBillPayments:(long long) billID;

- (AVOAPICreateMomentCommentResponse *) createMomentComment:(long long) momentID and:(AVOAPICreateMomentCommentRequest *) req;

- (AVOAPIGetMomentCommentsResponse *) getMomentComments:(long long) momentID and:(long long) startID and:(int) limit;

- (BOOL) updateTripMemberShip:(long long) tripID andShip:(AVOAPIUpdateTripMemberRequest *) req;

- (AVOAPIGetTripMembersResponse *) getTripMembers:(long long) tripID;

- (AVOAPIGetImageResponse *) getImage:(long long) imageID;

@end
