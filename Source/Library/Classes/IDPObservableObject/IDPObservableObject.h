//
//  IDPObservableObject.h
//  Test
//
//  Created by Oleksa Korin on 4/28/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPBlockObservationController;

@interface IDPObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger  state;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (IDPBlockObservationController *)blockObservationControllerWithObserver:(id)observer;

// these methods are called in subclasses
// you should never call this methods directly from outside subclasses
- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object;

@end
