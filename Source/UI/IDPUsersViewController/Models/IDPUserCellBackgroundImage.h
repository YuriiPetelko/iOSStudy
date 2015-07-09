//
//  IDPUserCellBackgroundImage.h
//  iOSProject
//
//  Created by Oleksa Korin on 7/1/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPImageModel.h"

@interface IDPUserCellBackgroundImage : IDPImageModel
@property (nonatomic, readonly) CGSize size;

+ (instancetype)imageWithSize:(CGSize)size;
- (instancetype)initWithSize:(CGSize)size;

- (void)save;

@end
