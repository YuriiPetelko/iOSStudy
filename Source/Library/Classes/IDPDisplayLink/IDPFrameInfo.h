//
//  IDPFrameInfo.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/23/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPFrameInfo : NSObject
@property (nonatomic, readonly) NSTimeInterval  duration;
@property (nonatomic, readonly) CFTimeInterval  timeStamp;
@property (nonatomic, readonly) NSUInteger      frameCount;

- (instancetype)initWithDuration:(NSTimeInterval)duration
                       timeStamp:(CFTimeInterval)timeStamp
                      frameCount:(NSUInteger)frameCount;

@end
