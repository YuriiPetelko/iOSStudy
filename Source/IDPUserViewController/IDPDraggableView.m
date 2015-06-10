//
//  IDPDraggableView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/10/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPDraggableView.h"

@interface IDPDraggableView ()
@property (nonatomic, retain)   UITouch *leadingTouch;

- (void)processTouches:(NSSet *)touches;

@end

@implementation IDPDraggableView

#pragma mark -
#pragma mark Touch Handling

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    self.leadingTouch = [touches anyObject];

    [self processTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [self processTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [self processTouches:touches];

    self.leadingTouch = nil;
}

- (void)touchesCancelled:(NSSet *)touches
               withEvent:(UIEvent *)event
{
    [self processTouches:touches];
    
    self.leadingTouch = nil;
}

#pragma mark -
#pragma mark Private

- (void)processTouches:(NSSet *)touches {
    if ([touches count] != 2) {
        return;
    }
    
    UITouch *touch = self.leadingTouch;
    CGPoint location = [touch locationInView:self];
    
    CGRect frame = self.frame;
    frame.origin = location;
    self.frame = frame;
}

@end
