//
//  AVOMomentPhoto.h
//  Avolo
//
//  Created by Zhengji Tao on 12/1/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOCommModel.h"

@interface AVOMomentPhoto : AVOCommModel

@property (nonatomic) long long photoID;
@property (nonatomic) long long imageID;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *note;

@property (nonatomic, retain) UIImage *photoImage;

@end
