//
//  IDPImageViewSpec.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/17/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "Kiwi.h"

#import <UIKit/UIKit.h>

#import "IDPTestView.h"

#import "IDPCompilerMacro.h"

SPEC_BEGIN(UIViewSpec)

IDPClangDiagnosticPushExpression("clang diagnostic ignored \"-Wunused-value\"")

describe(@"UIView", ^{
    __block UIView *view = [UIView alloc];
    
    context(@"when initializing using -init", ^{
        it(@"should call -init", ^{
            [[view should] receive:@selector(init)];
            [view init];
        });
        
        it(@"shouldn't call -initWithCoder:", ^{
            [[view shouldNot] receive:@selector(initWithCoder:)];
            [view init];
        });
        
        it(@"should call -initWithFrame:", ^{
            [[view should] receive:@selector(initWithFrame:)];
            [view init];
        });
    });
    
    context(@"when initializing using -initWithFrame:", ^{
        it(@"shouldn't call -init", ^{
            [[view shouldNot] receive:@selector(init)];
            [view initWithFrame:CGRectZero];
        });
        
        it(@"shouldn't call -initWithCoder:", ^{
            [[view shouldNot] receive:@selector(initWithCoder:)];
            [view initWithFrame:CGRectZero];
        });
        
        it(@"should call -initWithFrame:", ^{
            [[view should] receive:@selector(initWithFrame:)];
            [view initWithFrame:CGRectZero];
        });
    });
    
    context(@"when initializing using -initWithCoder:", ^{
        __block NSCoder *coder = nil;
        
        beforeEach(^{
            Class class = [IDPTestView class];
            NSBundle *bundle = [NSBundle bundleForClass:class];
            UINib *nib = [UINib nibWithNibName:NSStringFromClass(class) bundle:bundle];
            IDPTestView *testView = [[nib instantiateWithOwner:nil options:nil] firstObject];
            view = testView;
            coder = testView.coder;
        });
        
        it(@"shouldn't call -init", ^{
            [[view shouldNot] receive:@selector(init)];
            [view initWithCoder:coder];
        });
        
        it(@"should call -initWithCoder:", ^{
            [[view should] receive:@selector(initWithCoder:)];
            [view initWithCoder:coder];
        });
        
        it(@"shouldn't call -initWithFrame:", ^{
            [[view shouldNot] receive:@selector(initWithFrame:)];
            [view initWithCoder:coder];
        });
    });
});

IDPClangDiagnosticPopExpression

SPEC_END
