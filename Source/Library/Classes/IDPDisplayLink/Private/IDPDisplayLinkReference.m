//
//  IDPDisplayLinkReference.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/23/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPDisplayLinkReference.h"

#import "IDPDisplayLink.h"

@interface IDPDisplayLinkReference ()
@property (nonatomic, weak) IDPDisplayLink  *displayLink;

@end

@implementation IDPDisplayLinkReference

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithDisplayLink:(IDPDisplayLink *)displayLink {
    self = [super init];
    if (self) {
        self.displayLink = displayLink;
    }
    
    return self;
}

#pragma mark -
#pragma mark CADisplayLink action

- (void)onDisplayLink:(id)link {
    [self.displayLink onDisplayLink:link];
}

@end
