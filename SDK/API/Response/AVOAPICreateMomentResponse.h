//
//  AVOAPICreateMomentResponse.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOAPICreateMomentResponse : AVOCommModel

@property (nonatomic) long long momentID;
@property (nonatomic) long long momentPhotoID;
@property (nonatomic) long long momentBillID;
@property (nonatomic) long long momentNoteID;

@end
