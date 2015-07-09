//
//  IDPDisplayLink.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/23/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPObservableObject.h"

@class CADisplayLink;

typedef NS_ENUM(NSUInteger, IDPDisplayLinkState) {
    IDPDisplayLinkFrameRefresh
};

@interface IDPDisplayLink : IDPObservableObject
@property (nonatomic, readonly) NSUInteger  frameInterval;

+ (instancetype)sharedDisplayLink;

- (instancetype)initWithFrameInterval:(NSUInteger)frameInterval;

// this method is intended for subclassing only
// never call it directly
- (void)onDisplayLink:(CADisplayLink *)link;

@end
