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

@end

@implementation IDPFrameInfo

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithDuration:(NSTimeInterval)duration
                       timeStamp:(CFTimeInterval)timeStamp
{
    self = [super init];
    if (self) {
        self.duration = duration;
        self.timeStamp = timeStamp;
    }
    
    return self;
}

@end
