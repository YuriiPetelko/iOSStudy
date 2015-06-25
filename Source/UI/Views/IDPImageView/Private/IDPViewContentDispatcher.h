//
//  IDPViewContentDispatcher.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/24/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPViewContentOperation;

@interface IDPViewContentDispatcher : NSObject

+ (instancetype)sharedObject;

- (void)addViewContentOperation:(IDPViewContentOperation *)operation;
- (void)removeViewContentOperation:(IDPViewContentOperation *)operation;

@end
