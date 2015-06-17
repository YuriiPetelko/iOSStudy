//
//  IDPObservationController_IDPPrivate.h
//  Test
//
//  Created by Oleksa Korin on 5/4/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPObservationController.h"

@interface IDPObservationController ()

- (void)notifyWithState:(NSUInteger)state;
- (void)notifyWithState:(NSUInteger)state object:(id)object;

@end
