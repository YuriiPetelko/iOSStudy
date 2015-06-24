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
        
        self.observer = [imageModel blockObservationControllerWithObserver:self];
        
        IDPWeakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                       dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0),
                       ^{
                           IDPStrongifyAndReturnIfNil(self);
                           if (self.imageModel == imageModel) {
                               [imageModel load];
                           }
                       });
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
        void(^block)(void) = ^{
            IDPStrongifyAndReturnIfNil(self);
            
            IDPImageModel *model = controller.observableObject;
            self.contentImageView.image = model.image;
        };
        
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
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
