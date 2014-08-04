//
//  AVOUserToken.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOUserToken : AVOCommModel<NSCoding>

@property (nonatomic, retain) NSString *token;
@property (nonatomic) long long expires;
@property (nonatomic) long long userID;

@end
