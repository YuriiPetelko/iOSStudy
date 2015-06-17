//
//  IDPBlockObservationController.h
//  Test
//
//  Created by Oleksa Korin on 5/4/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPObservationController.h"

typedef void(^IDPStateChangeHandler)(IDPBlockObservationController *controller, id userInfo);

@interface IDPBlockObservationController : IDPObservationController

- (void)setHandler:(IDPStateChangeHandler)handler
          forState:(NSUInteger)state;

- (void)removeHandlerForState:(NSUInteger)state;

- (IDPStateChangeHandler)handlerForState:(NSUInteger)state;

- (BOOL)containsHandlerForState:(NSUInteger)state;

// states require termination with -1 or NSUIntegerMax
- (void)setHandler:(IDPStateChangeHandler)handler
         forStates:(NSUInteger)state, ...;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index;

@end
