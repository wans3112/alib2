//
//  AVOMomentComment.h
//  Avolo
//
//  Created by Zhengji Tao on 12/10/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOUser.h"

@interface AVOMomentComment : AVOCommModel

@property (nonatomic) long long ID;
@property (nonatomic) long long posterID;
@property (nonatomic, retain) NSString *text;
@property (nonatomic) long long date;

@property (nonatomic, strong) AVOUser *posterUser;
@property (nonatomic, strong) NSDate *postDate;

@end
