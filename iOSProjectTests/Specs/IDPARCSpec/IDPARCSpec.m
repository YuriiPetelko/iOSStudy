//
//  IDPARC.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/8/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "Kiwi.h"
#import "IDPARCObject.h"

SPEC_BEGIN(IDPARCSpec)

describe(@"ARC", ^{
    IDPARCObject *object = [IDPARCObject new];
    
    context(@"when putting object into strong property", ^{
        beforeEach(^{
            NSObject *input = [NSObject new];
            object.strongObject = input;
        });
        
        it(@"should be contained in that property", ^{
            [[object.strongObject shouldNot] beNil];
        });
    });
    
    context(@"when putting object into weak property", ^{
        __block NSObject *input = [NSObject new];
        
        beforeEach(^{
            object.weakObject = input;
        });
        
        it(@"should be contained in that property", ^{
            __weak id value = object.weakObject;
            [[theValue(value) shouldNot] equal:theValue(nil)];
        });
        
        context(@"after the object in weak property is released", ^{
            it(@"should be zeroed out", ^{
                __weak id value = object.weakObject;
                input = nil;
                [[theValue(value) shouldNot] equal:theValue(nil)];
            });
        });
    });
    
    context(@"when passing blocks to GCD in async manner", ^{
        beforeEach(^{
            id string = [NSString new];
            __weak id weakString = string;
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
                __strong id strongString = weakString;
                if (!strongString) {
                    return;
                }
                
                NSLog(@"%@", [strongString description]);
                sleep(2);
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [weakString stringByAbbreviatingWithTildeInPath];
                });
            });
        });
    });
});

SPEC_END