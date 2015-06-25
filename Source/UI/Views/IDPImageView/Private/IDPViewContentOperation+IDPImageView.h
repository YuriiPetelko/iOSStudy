//
//  IDPViewContentOperation+IDPImageView.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/24/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPViewContentOperation.h"

@class IDPImageView;
@class IDPImageModel;

@interface IDPViewContentOperation (IDPImageView)

+ (instancetype)operationWithImageView:(IDPImageView *)imageView
                            imageModel:(IDPImageModel *)imageModel;

@end
