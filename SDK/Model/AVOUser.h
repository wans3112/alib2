//
//  AVOUser.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOUser : AVOCommModel

@property (nonatomic) long long userID;

@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic) long long imageID;

@property (nonatomic, retain) UIImage *headImage;
@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *imageUrl;

@end
