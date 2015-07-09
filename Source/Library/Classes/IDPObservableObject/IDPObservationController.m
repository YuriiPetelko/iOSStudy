//
//  IDPObservationController.m
//  Test
//
//  Created by Oleksa Korin on 4/29/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPObservationController.h"

#import "IDPObservationController+IDPPrivate.h"
#import "IDPObservableObject+IDPPrivate.h"

static NSString * const kIDPObservationControllerAllocationException    = @"IDPObservationController should never be"
                                                @"instantiated directly.";

@interface IDPObservationController ()
@property (nonatomic, assign) id    observer;
@property (nonatomic, assign) id    observableObject;

@end

@implementation IDPObservationController

@dynamic valid;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)observationControllerWithObserver:(id)observer
                                 observableObject:(IDPObservableObject *)observableObject;
{
    return [[self alloc] initWithObserver:observer
                         observableObject:observableObject];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    NSAssert([self class] != [IDPObservationController class], kIDPObservationControllerAllocationException);
    
    return [super allocWithZone:zone];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observableObject = nil;
}

- (instancetype)initWithObserver:(id)observer
                observableObject:(IDPObservableObject *)observableObject
{
    NSAssert(nil != observer, NSInvalidArgumentException);
    NSAssert(nil != observableObject, NSInvalidArgumentException);
    
    self = [super init];
    if (self) {
        self.observer = observer;
        self.observableObject = observableObject;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setObservableObject:(IDPObservableObject *)observableObject {
    if (nil == observableObject) {
        [_observableObject invalidateController:self];
    }
    
    _observableObject = observableObject;
}

- (BOOL)isValid {
    return nil != self.observableObject || nil != self.observer;
}

#pragma mark -
#pragma mark Public

- (void)invalidate {
    self.observableObject = nil;
    self.observer = nil;
}

- (NSUInteger)hash {
    return [[self class] hash] ^ [self.observer hash] ^ [self.observableObject hash];
}

- (BOOL)isEqual:(IDPObservationController *)controller {
    if (!controller) {
        return NO;
    }
    
    if (controller == self) {
        return YES;
    }
    
    if ([self isMemberOfClass:[controller class]]) {
        return controller.observer == self.observer
            && controller.observableObject == self.observableObject;
    }
    
    return NO;
}

#pragma mark -
#pragma mark Private

- (void)notifyWithState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)notifyWithState:(NSUInteger)state object:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

@end
