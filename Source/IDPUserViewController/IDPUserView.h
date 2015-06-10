//
//  IDPUserView.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPUser;
@class IDPDraggableView;

@interface IDPUserView : UIView
@property (nonatomic, strong)   IBOutlet UILabel            *label;
@property (nonatomic, strong)   IBOutlet UIButton           *button;
@property (nonatomic, strong)   IBOutlet IDPDraggableView   *draggableView;
@property (nonatomic, strong)   IDPUser                     *user;

- (void)rotateLabel;

- (void)fillWithUser:(IDPUser *)user;

@end
