//
//  IDPDisplayLinkReference.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/23/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPDisplayLink;
@class CADisplayLink;

@interface IDPDisplayLinkReference : NSObject
@property (nonatomic, weak, readonly) IDPDisplayLink  *displayLink;

- (instancetype)initWithDisplayLink:(IDPDisplayLink *)displayLink;

- (void)onDisplayLink:(CADisplayLink *)link;

@end
