//
//  IDPImageView.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/17/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPImageModel;

@interface IDPImageView : UIView
@property (nonatomic, strong)   IBOutlet UIImageView     *contentImageView;

@property (nonatomic, strong)   IDPImageModel   *imageModel;

// this methods are used for subclassing purposes only
// you should never call them directly
- (void)modelDidLoad:(IDPImageModel *)model;

@end
