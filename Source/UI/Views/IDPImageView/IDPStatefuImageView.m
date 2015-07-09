//
//  IDPStatefuImageView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/25/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPStatefuImageView.h"

#import "IDPImageModel.h"
#import "IDPViewContentDispatcher.h"

#import "IDPViewContentOperation+IDPImageView.h"

@implementation IDPStatefuImageView

#pragma mark -
#pragma mark Accessors

- (void)setImageModel:(IDPImageModel *)imageModel {
    if (imageModel && imageModel != self.imageModel) {
        [self.activityIndicator startAnimating];
    }
    
    [super setImageModel:imageModel];
}

#pragma mark -
#pragma mark Public

- (void)modelDidLoad:(IDPImageModel *)model {
    IDPViewContentOperation *operation = [IDPViewContentOperation operationWithImageView:self imageModel:model];

    IDPViewSetContent contentSetter = operation.contentSetter;
    operation.contentSetter = ^(IDPImageView *view, UIImage *content) {
        [self.activityIndicator stopAnimating];
        contentSetter(view, content);
    };
    
    [[IDPViewContentDispatcher sharedObject] addViewContentOperation:operation];
}

@end
