//
//  IDPDraggableView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/10/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPDraggableView.h"

//static NSUInteger IDPTouchCount     = 1;
static NSTimeInterval IDPDuration   = 1.0;

@interface IDPDraggableView ()
@property (nonatomic, retain)   UITouch *leadingTouch;

//- (void)processTouches:(NSSet *)touches;
- (void)moveToLocation:(CGPoint)location;

@end

@implementation IDPDraggableView

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    [self moveToLocation:[sender translationInView:self]];
}

#pragma mark -
#pragma mark Touch Handling

//- (void)touchesBegan:(NSSet *)touches
//           withEvent:(UIEvent *)event
//{
//    NSLog(@"began");
//    self.leadingTouch = [touches anyObject];
//
//    [self processTouches:touches];
//}
//
//- (void)touchesMoved:(NSSet *)touches
//           withEvent:(UIEvent *)event
//{
//    NSLog(@"moved");
//    [self processTouches:touches];
//}
//
//- (void)touchesEnded:(NSSet *)touches
//           withEvent:(UIEvent *)event
//{
//    NSLog(@"ended");
//    [self processTouches:touches];
//
//    self.leadingTouch = nil;
//}
//
//- (void)touchesCancelled:(NSSet *)touches
//               withEvent:(UIEvent *)event
//{
//    NSLog(@"cancelled");
//    [self processTouches:touches];
//    
//    self.leadingTouch = nil;
//}

#pragma mark -
#pragma mark Private

//- (void)processTouches:(NSSet *)touches {
//    if ([touches count] != IDPTouchCount) {
//        return;
//    }
//    
//    UITouch *touch = self.leadingTouch;
//    CGPoint location = [touch locationInView:self.superview];
//    
//    CGFloat random = (CGFloat)arc4random() / UINT32_MAX;
//    CGFloat scale = random;
//    NSLog(@"%f", scale);
//    
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeScale(scale, scale));
//    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeRotation(random * 2 * M_PI));
//
//    CGRect frame = self.frame;
//    frame.origin = location;
//
//    [UIView animateWithDuration:IDPDuration
//                          delay:0
//                        options:UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
////                         self.frame = frame;
//                         self.transform = transform;
//                     }
//                     completion:nil];
//}

- (void)moveToLocation:(CGPoint)location {
    CGRect frame = self.frame;
    frame.origin = location;
    
    [UIView animateWithDuration:IDPDuration
                     animations:^{
                         self.frame = frame;
                     }];
    
}

@end
