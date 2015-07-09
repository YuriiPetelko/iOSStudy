//
//  IDPObservableObject.m
//  Test
//
//  Created by Oleksa Korin on 4/28/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPBlockObservationController.h"

#import "IDPObservableObject+IDPPrivate.h"
#import "IDPObservationController+IDPPrivate.h"

typedef void(^IDPControllerNotificationBlock)(IDPObservationController *controller);

@interface IDPObservableObject ()
@property (nonatomic, retain)   NSHashTable    *observationControllerHashTable;

- (void)notifyOfStateChange:(NSUInteger)state
                withHandler:(IDPControllerNotificationBlock)handler;

- (id)observationControllerWithClass:(Class)class observer:(id)observer;

@end

@implementation IDPObservableObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observationControllerHashTable = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observationControllerHashTable = [NSHashTable weakObjectsHashTable];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observerSet {
    return [self.observationControllerHashTable setRepresentation];
}

- (void)setState:(NSUInteger)state {
    if (state != _state) {
        _state = state;
        
        [self notifyOfStateChange:state];
    }
}

- (void)setState:(NSUInteger)state withObject:(id)object {
    if (state != _state) {
        _state = state;
        
        [self notifyOfStateChange:state withObject:object];
    }
}

#pragma mark -
#pragma mark Public

- (IDPBlockObservationController *)blockObservationControllerWithObserver:(id)observer {
    return [self observationControllerWithClass:[IDPBlockObservationController class]
                                       observer:observer];
}

#pragma mark -
#pragma mark Private

- (id)observationControllerWithClass:(Class)class observer:(id)observer {
    IDPObservationController *result = [class observationControllerWithObserver:observer
                                                               observableObject:self];
    
    [self.observationControllerHashTable addObject:result];
    
    return result;
}

- (void)invalidateController:(IDPObservationController *)controller {
    [self.observationControllerHashTable removeObject:controller];
}

- (void)notifyOfStateChange:(NSUInteger)state {
    [self notifyOfStateChange:state
                  withHandler:^(IDPObservationController *controller) {
                      [controller notifyWithState:state];
                  }];
}

- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object {
    [self notifyOfStateChange:state
                  withHandler:^(IDPObservationController *controller) {
                      [controller notifyWithState:state object:object];
                  }];
}

- (void)notifyOfStateChange:(NSUInteger)state
                withHandler:(IDPControllerNotificationBlock)handler
{
    if (!handler) {
        return;
    }
    
    NSHashTable *controllers = self.observationControllerHashTable;
    for (IDPObservationController *controller in controllers) {
        handler(controller);
    }
}

@end
