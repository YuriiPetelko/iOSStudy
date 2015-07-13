//
//  IDPUserView.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPUser;

@interface IDPUserView : UIView
@property (nonatomic, strong)   IBOutlet UILabel            *label;
@property (nonatomic, strong)   IBOutlet UIButton           *dismissButton;
@property (nonatomic, strong)   IDPUser                     *user;

- (void)fillWithUser:(IDPUser *)user;

@end
