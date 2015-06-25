//
//  IDPFrameInfo.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/23/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPFrameInfo.h"

@interface IDPFrameInfo ()
@property (nonatomic, assign) NSTimeInterval  duration;
@property (nonatomic, assign) CFTimeInterval  timeStamp;
@property (nonatomic, assign) NSUInteger      frameCount;

@end

@implementation IDPFrameInfo

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithDuration:(NSTimeInterval)duration
                       timeStamp:(CFTimeInterval)timeStamp
                      frameCount:(NSUInteger)frameCount
{
    self = [super init];
    if (self) {
        self.duration = duration;
        self.timeStamp = timeStamp;
        self.frameCount = frameCount;
    }
    
    return self;
}

@end
