//
//  AVOAPICreateImageResponse.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOImageLink.h"

@interface AVOAPICreateImageResponse : AVOCommModel

@property (nonatomic) long long imageID;
@property (nonatomic, retain) AVOImageLink *imageLink;

@end
