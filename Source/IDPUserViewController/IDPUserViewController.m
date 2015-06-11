//
//  IDPUserViewController.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPUserViewController.h"

#import "IDPUserView.h"

@interface IDPUserViewController ()
@property (nonatomic, readonly) IDPUserView    *userView;

@end

@implementation IDPUserViewController

#pragma mark -
#pragma mark Accessors

- (void)setUser:(IDPUser *)user {
    if (_user != user) {
        _user = user;
    }
    
    self.userView.user = user;
}

- (IDPUserView *)userView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[IDPUserView class]]) {
        return (IDPUserView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userView.user = self.user;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onRotateButton:(id)sender {
    [self.userView rotateLabel];
}

@end
