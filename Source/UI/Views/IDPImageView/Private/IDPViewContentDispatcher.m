//
//  IDPViewContentDispatcher.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/24/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPViewContentDispatcher.h"

#import "IDPViewContentOperation.h"
#import "IDPDisplayLink.h"
#import "IDPBlockObservationController.h"
#import "IDPFrameInfo.h"

#import "IDPMacro.h"

@interface IDPViewContentDispatcher ()
@property (nonatomic, strong)   NSMutableArray                  *operations;
@property (nonatomic, strong)   IDPDisplayLink                  *displayLink;
@property (nonatomic, strong)   IDPBlockObservationController   *observer;

- (void)initDisplayLink;

@end

@implementation IDPViewContentDispatcher

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedObject {
    static dispatch_once_t onceToken;
    static id __sharedObject = nil;
    dispatch_once(&onceToken, ^{
        __sharedObject = [self new];
    });
    
    return __sharedObject;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.operations = [NSMutableArray array];
        [self initDisplayLink];
    }
    
    return self;
}

- (void)initDisplayLink {
    IDPDisplayLink *displayLink = [IDPDisplayLink sharedDisplayLink];
    IDPBlockObservationController *observer = [displayLink blockObservationControllerWithObserver:self];
    
    IDPWeakify(self);
    id handler = ^(IDPBlockObservationController *controller, IDPFrameInfo *frameInfo) {
        IDPStrongify(self);
        @synchronized (self) {
            NSMutableArray *operations = self.operations;
            IDPViewContentOperation *operation = nil;
            
            do {
                operation = [operations firstObject];
                if (operation) {
                    [operations removeObjectAtIndex:0];
                    if (IDPViewContentOperationInvalid != operation.state) {
                        [operation execute];
                        break;
                    }
                }
            } while ([operations count] > 0);
        }
    };
    
    [observer setHandler:handler forState:IDPDisplayLinkFrameRefresh];
    
    self.observer = observer;
    self.displayLink = displayLink;
}

#pragma mark -
#pragma mark Public

- (void)addViewContentOperation:(IDPViewContentOperation *)operation {
    @synchronized (self) {
        [self.operations addObject:operation];
    }
}

- (void)removeViewContentOperation:(IDPViewContentOperation *)operation {
    @synchronized (self) {
        [self.operations removeObject:operation];
    }
}

@end
