//
//  IDPObservationController.h
//  Test
//
//  Created by Oleksa Korin on 4/29/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObservableObject.h"

@interface IDPObservationController : NSObject
@property (nonatomic, readonly) id      observer;
@property (nonatomic, readonly) id      observableObject;

@property (nonatomic, readonly, getter=isValid) BOOL    valid;

+ (instancetype)observationControllerWithObserver:(id)observer
                                 observableObject:(IDPObservableObject *)observableObject;

- (instancetype)initWithObserver:(id)observer
                observableObject:(IDPObservableObject *)observableObject;

// Invaldiates the object. Notifications won't be passed through it and it will
// be removed from observableObject at some point.
- (void)invalidate;

@end
