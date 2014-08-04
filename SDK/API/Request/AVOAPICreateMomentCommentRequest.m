//
//  AVOAPICreateMomentCommentRequest.m
//  Avolo
//
//  Created by Zhengji Tao on 12/10/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateMomentCommentRequest.h"

#define KEY_COMMENT @"comment"

@implementation AVOAPICreateMomentCommentRequest
@synthesize comment;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.comment = [[[AVOMomentComment alloc] init] fromDictionary:[dict objectForKey:comment]];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[self.comment toDictionary], KEY_COMMENT, nil];
}

@end
