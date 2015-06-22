//
//  IDPImageView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/17/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPImageView.h"

#import "IDPImageModel.h"

@interface IDPImageView ()

- (void)initSubviews;

@end

@implementation IDPImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.contentImageView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.contentImageView) {
        [self initSubviews];
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setContentImageView:(UIImageView *)contentImageView {
    if (contentImageView != _contentImageView) {
        [_contentImageView removeFromSuperview];
        _contentImageView = contentImageView;
        [self addSubview:contentImageView];
    }
}

#pragma mark -
#pragma mark View Lifecycle



#pragma mark -
#pragma mark Private

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
                                    | UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleRightMargin
                                    | UIViewAutoresizingFlexibleTopMargin
                                    | UIViewAutoresizingFlexibleHeight
                                    | UIViewAutoresizingFlexibleBottomMargin;
    
    self.contentImageView = imageView;
}

@end
