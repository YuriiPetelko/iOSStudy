//
//  IDPUserView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPUserView.h"

#import <math.h>

#import "IDPUser.h"

@implementation IDPUserView

#pragma mark -
#pragma mark Accessors

- (void)setUser:(IDPUser *)user {
    if (_user != user) {
        _user = user;
        
        [self fillWithUser:user];
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(IDPUser *)user {
    self.label.text = user.fullName;
}

- (void)rotateLabel {
    self.label.transform = CGAffineTransformMakeRotation((float)arc4random() / UINT32_MAX * 2 * M_PI);
}

@end
