//
//  AVOLocalCredential.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOLocalCredential : AVOCommModel<NSCoding>

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *passHash;

@end
