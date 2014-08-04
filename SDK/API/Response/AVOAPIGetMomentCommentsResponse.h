//
//  AVOAPIGetMomentCommentsResponse.h
//  Avolo
//
//  Created by Zhengji Tao on 12/10/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOMomentComment.h"

@interface AVOAPIGetMomentCommentsResponse : AVOCommModel

@property (nonatomic) long long momentID;
@property (nonatomic, retain) NSArray *comments;

@end
