//
//  IDPImageModelDispatcher.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/16/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPImageModelDispatcher.h"

@interface IDPImageModelDispatcher ()
@property (nonatomic, strong)     NSOperationQueue    *queue;

- (void)initQueue;

@end

@implementation IDPImageModelDispatcher

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedDispatcher {
    static dispatch_once_t onceToken;
    static id dispatcher = nil;
    dispatch_once(&onceToken, ^{
        dispatcher = [self new];
    });
    
    return dispatcher;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.queue = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initQueue];
    }
    
    return self;
}

- (void)initQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    
    self.queue = queue;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        [_queue cancelAllOperations];
        
        _queue = queue;
    }
}

@end
