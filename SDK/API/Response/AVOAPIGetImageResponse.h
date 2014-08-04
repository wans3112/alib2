//
//  AVOAPIGetImageResponse.h
//  Avolo
//
//  Created by Zhengji Tao on 12/14/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"
#import "AVOImageLink.h"

@interface AVOAPIGetImageResponse : AVOCommModel

@property (nonatomic, retain) AVOImageLink *image;

@end
