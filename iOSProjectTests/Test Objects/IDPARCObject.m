//
//  IDPARCObject.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/8/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPARCObject.h"

#import <objc/runtime.h>

@implementation IDPARCObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    
}

#pragma mark -
#pragma mark Accessors

- (void)setStrongObject:(id)strongObject {
    if (_strongObject != strongObject) {
#if __has_feature(objc_arc)
        _strongObject = strongObject;
#else
        [_strongObject release];
        _strongObject = [strongObject retain];
#endif
    }
}

- (void)setWeakObject:(id)weakObject {
    if (_weakObject != weakObject) {
        _weakObject = weakObject;
    }
}

- (void)setAssignObject:(id)assignObject {
    if (_assignObject != assignObject) {
        _assignObject = assignObject;
    }
}

#pragma mark -
#pragma mark Public

- (void)execute {
    NSObject *object = [NSObject new];
    self.weakObject = object;
    
    object = nil;
    
    NSLog(@"mama");
}

@end
