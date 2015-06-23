//
//  IDPDisplayLink.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/23/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPDisplayLink.h"

#import <QuartzCore/QuartzCore.h>

#import "IDPDisplayLinkReference.h"
#import "IDPFrameInfo.h"

static NSInteger const kIDPDisplayLinkDefaultTimeInterval   = 1;

@interface IDPDisplayLink ()
@property (nonatomic, strong)   CADisplayLink   *displayLink;
@property (nonatomic, assign)   NSUInteger      frameInterval;

- (void)initDisplayLink;

@end

@implementation IDPDisplayLink

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedDisplayLink {
    static IDPDisplayLink *__sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedObject = [[self alloc] initWithFrameInterval:kIDPDisplayLinkDefaultTimeInterval];
    });
    
    return __sharedObject;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.displayLink = nil;
}

- (instancetype)initWithFrameInterval:(NSUInteger)frameInterval {
    self = [super init];
    if (self) {
        self.frameInterval = frameInterval;
        [self initDisplayLink];
    }
    
    return self;
}

- (void)initDisplayLink {
    IDPDisplayLinkReference *reference = [[IDPDisplayLinkReference alloc] initWithDisplayLink:self];
    self.displayLink = [CADisplayLink displayLinkWithTarget:reference
                                                   selector:@selector(onDisplayLink:)];
}

#pragma mark -
#pragma mark Accessors

- (void)setDisplayLink:(CADisplayLink *)displayLink {
    if (displayLink != _displayLink) {
        [_displayLink invalidate];
        
        _displayLink = displayLink;
        
        displayLink.frameInterval = self.frameInterval;
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    }
}

#pragma mark -
#pragma mark CADisplayLink action

- (void)onDisplayLink:(CADisplayLink *)link {
    IDPFrameInfo *info = [[IDPFrameInfo alloc] initWithDuration:link.duration
                                                      timeStamp:link.timestamp];
    
    [self setState:IDPDisplayLinkFrameRefresh withObject:info];
}

@end
