//
//  IDPViewContentOperation+IDPImageView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/24/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPViewContentOperation+IDPImageView.h"

#import "IDPImageView.h"
#import "IDPImageModel.h"

@implementation IDPViewContentOperation (IDPImageView)

+ (instancetype)operationWithImageView:(IDPImageView *)imageView
                            imageModel:(IDPImageModel *)imageModel
{
    NSString *keyPath = NSStringFromSelector(@selector(imageModel));
    IDPViewContentOperation *operation = [[IDPViewContentOperation alloc] initWithModel:imageModel
                                                                                   view:imageView
                                                                       viewModelKeyPath:keyPath];
    
    operation.contentGetter = ^(IDPImageModel *model) {
        return model.image;
    };
    
    operation.contentSetter = ^(IDPImageView *view, UIImage *content) {
        view.contentImageView.image = content;
    };
    
    return operation;
}

@end
