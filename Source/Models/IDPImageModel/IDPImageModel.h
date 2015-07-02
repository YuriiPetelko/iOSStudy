//
//  IDPImageModel.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/16/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPObservableObject.h"

typedef NS_ENUM(NSUInteger, IDPImageModelState) {
    IDPImageModelUnloaded,
    IDPImageModelLoading,
    IDPImageModelLoaded,
    IDPImageModelFailedLoading
};

@interface IDPImageModel : IDPObservableObject
@property (nonatomic, strong)   UIImage  *image;
@property (nonatomic, readonly) NSURL    *url;

+ (instancetype)imageWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (void)load;
- (void)dump;

// this method is intended for suclassing purposes only
// you should never call it directly
- (NSOperation *)imageLoadingOperation;

@end
