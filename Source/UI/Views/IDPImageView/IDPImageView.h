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

@end
