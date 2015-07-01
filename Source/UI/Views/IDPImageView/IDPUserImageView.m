//
//  IDPUserImageView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/29/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "IDPUserImageView.h"

@interface IDPUserImageView ()

- (void)drawImproperGradientLineInContext:(CGContextRef)context;
- (void)drawPathGradientLineInContext:(CGContextRef)context;
- (void)drawRectGradientLineInContext:(CGContextRef)context;
- (void)drawRotatedRectInContext:(CGContextRef)context;
- (void)drawGradientInContext:(CGContextRef)context;

@end

@implementation IDPUserImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)awakeFromNib {
    [super awakeFromNib];

//    CALayer *layer = self.layer;
//    layer.borderColor = [UIColor redColor].CGColor;
//    layer.borderWidth = 2.0;
}

#pragma mark -
#pragma mark Public

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIImageView *imageView = self.contentImageView;
    imageView.hidden = YES;
    imageView.opaque = YES;
    
    CGRect frame = self.frame;
    CGFloat dimension = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame));
    frame.origin = CGPointMake((CGRectGetWidth(frame) - dimension) / 2.0,
                               (CGRectGetHeight(frame) - dimension) / 2.0);
    frame.size = CGSizeMake(dimension, dimension);
    
//    imageView.frame = frame;
    
//    CALayer *layer = imageView.layer;
//    layer.cornerRadius = dimension / 2.0;
//    layer.borderColor = [UIColor greenColor].CGColor;
//    layer.borderWidth = 2.0;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self drawRotatedRectInContext:context];
    [self drawRectGradientLineInContext:context];
}

- (void)drawPathGradientLineInContext:(CGContextRef)context {
    CGContextSaveGState(context);
    
    CGRect frame = self.bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGFloat lineWidth = 20;
    CGFloat radius = lineWidth / 2.0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, center.y - lineWidth - radius);
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(frame) - radius, center.y - lineWidth - radius);
//    CGPathAddArcToPoint(path,
//                        NULL,
//                        CGRectGetMaxX(frame) - radius,
//                        center.y - lineWidth - radius,
//                        CGRectGetMaxX(frame) - radius,
//                        center.y - lineWidth + radius,
//                        radius);
    
    CGPathAddArc(path,
                 NULL,
                 CGRectGetMaxX(frame) - radius,
                 center.y - lineWidth,
                 radius,
                 -M_PI_2,
                 M_PI_2,
                 false);
    
    CGPathAddLineToPoint(path, NULL, 0, center.y - lineWidth + radius);
    
    CGPathCloseSubpath(path);
    
    CGPathMoveToPoint(path, NULL, center.x, center.y + lineWidth + radius * 2);
    
    CGPathAddArc(path,
                 NULL,
                 center.x,
                 center.y + lineWidth + radius * 2,
                 radius,
                 0,
                 2 * M_PI,
                 false);
    
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    
    CGContextSetShadow(context, CGSizeMake(20, 20), 10.0);
    
    CGContextClip(context);
    
    [self drawGradientInContext:context];
    
    CGPathRelease(path);
    
    CGContextRestoreGState(context);
}

- (void)drawRectGradientLineInContext:(CGContextRef)context {
    CGContextSaveGState(context);
    
    CGRect frame = self.bounds;
    
    CGFloat lineWidth = 10;
    CGRect lineRect = CGRectMake(0,
                                 CGRectGetMidY(frame) - lineWidth / 2.0,
                                 CGRectGetWidth(frame),
                                 lineWidth);
    
    CGRect lineRect1 = CGRectMake(0,
                                 0,
                                 CGRectGetWidth(frame),
                                 lineWidth);
    
    CGContextAddRect(context, lineRect);
    CGContextAddRect(context, lineRect1);
    
    CGContextClip(context);
    
    [self drawGradientInContext:context];
    
    CGContextRestoreGState(context);
}

- (void)drawImproperGradientLineInContext:(CGContextRef)context {
    CGContextSaveGState(context);
    
    CGRect frame = self.bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    
    [self drawGradientInContext:context];
    
    CGFloat lineWidth = 10;
    
    CGContextFillRect(context, CGRectMake(0,
                                          0,
                                          CGRectGetWidth(frame),
                                          center.y - lineWidth / 2.0));
    
    CGContextFillRect(context, CGRectMake(0,
                                          center.y + lineWidth / 2.0,
                                          CGRectGetWidth(frame),
                                          CGRectGetHeight(frame) - center.y - lineWidth / 2.0));
    
    CGContextRestoreGState(context);
}

- (void)drawGradientInContext:(CGContextRef)context {
    CGRect frame = self.bounds;
    
    const size_t colorCount = 2;
    const size_t componentCount = 4 * colorCount;
    const CGFloat colors[componentCount] = {1, 0, 0, 1,
        0, 1, 0, 1};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                                 colors,
                                                                 NULL,
                                                                 colorCount);
    
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    
    CGContextDrawLinearGradient(context,
                                gradient,
                                CGPointMake(0, center.y),
                                CGPointMake(CGRectGetWidth(frame), center.y),
                                0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)drawRotatedRectInContext:(CGContextRef)context {
    CGContextSaveGState(context);
    
    CGRect bounds = self.bounds;
    
    CGSize size = CGSizeMake(50, 50);
    
    CGRect frame = CGRectMake((CGRectGetWidth(bounds) - size.width) / 2.0,
                              (CGRectGetHeight(bounds) - size.height) / 2.0 ,
                              size.width,
                              size.height);
    
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeTranslation(-center.x, -center.y));
    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeRotation(M_PI_4));
    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeTranslation(center.x, center.y));
    
    CGContextConcatCTM(context, transform);
    
    CGContextFillRect(context, frame);
    
    CGContextRestoreGState(context);
}

@end
