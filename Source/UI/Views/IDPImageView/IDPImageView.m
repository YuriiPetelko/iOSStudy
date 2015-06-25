//
//  IDPImageView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/17/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPImageView.h"

#import "IDPImageModel.h"
#import "IDPBlockObservationController.h"
#import "IDPViewContentDispatcher.h"

#import "IDPViewContentOperation+IDPImageView.h"

#import "IDPMacro.h"

@interface IDPImageView ()
@property (nonatomic, strong)   IDPBlockObservationController   *observer;

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

#pragma mark -
#pragma mark Accessors

- (void)setContentImageView:(UIImageView *)contentImageView {
    if (contentImageView != _contentImageView) {
        [_contentImageView removeFromSuperview];
        _contentImageView = contentImageView;
        [self addSubview:contentImageView];
    }
}

- (void)setImageModel:(IDPImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel dump];
        _imageModel = imageModel;
        
        if (imageModel) {
            self.observer = [imageModel blockObservationControllerWithObserver:self];
            [imageModel load];
        } else {
            self.contentImageView.image = nil;
        }
    }
}

- (void)setObserver:(IDPBlockObservationController *)observer {
    if (observer != _observer) {
        _observer = observer;
        
        [self prepareObserver:observer];
    }
}

#pragma mark -
#pragma mark View Lifecycle



#pragma mark -
#pragma mark Private

- (void)prepareObserver:(IDPBlockObservationController *)observer {
    IDPWeakify(self);
    id handler = ^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongifyAndReturnIfNil(self);
        
        IDPImageModel *model = controller.observableObject;
        
        id operation = [IDPViewContentOperation operationWithImageView:self imageModel:model];
        [[IDPViewContentDispatcher sharedObject] addViewContentOperation:operation];
    };
    
    [observer setHandler:handler forState:IDPImageModelLoaded];
    [observer setHandler:handler forState:IDPImageModelUnloaded];
    
    
    handler = ^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongifyAndReturnIfNil(self);
        
        [self.imageModel load];
    };
    
    [observer setHandler:handler forState:IDPImageModelFailedLoading];
}

@end
