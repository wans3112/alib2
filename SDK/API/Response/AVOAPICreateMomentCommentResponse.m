//
//  AVOAPICreateMomentCommentResponse.m
//  Avolo
//
//  Created by Zhengji Tao on 12/10/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import "AVOAPICreateMomentCommentResponse.h"

#define KEY_COMMENT_ID @"commentID"

@implementation AVOAPICreateMomentCommentResponse
@synthesize commentID;

-(id)fromDictionary:(NSDictionary *)dict {
    if(dict!=nil) {
        self.commentID = [[dict objectForKey:KEY_COMMENT_ID] longLongValue];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:self.commentID], KEY_COMMENT_ID, nil];
}

@end
