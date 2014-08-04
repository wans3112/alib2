//
//  AVOImageLink.h
//  Avolo
//
//  Created by Zhengji Tao on 11/30/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOImageLink : AVOCommModel

@property (nonatomic, retain) NSString *secret;
@property (nonatomic, retain) NSString *url;
@property (nonatomic) enum AVO_ImageAvaliable avaliable;

@end
