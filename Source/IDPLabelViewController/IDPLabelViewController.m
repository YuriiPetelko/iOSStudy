//
//  IDPLabelViewController.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPLabelViewController.h"

#import "IDPLabelView.h"

@interface IDPLabelViewController ()
@property (nonatomic, readonly) IDPLabelView    *labelView;

@end

@implementation IDPLabelViewController

#pragma mark -
#pragma mark Accessors

- (void)setData:(NSString *)data {
    if (_data != data) {
        _data = data;
        
        self.labelView.label.text = data;
    }
}

- (IDPLabelView *)labelView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[IDPLabelView class]]) {
        return (IDPLabelView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.labelView.label.text = @"PAPA";
//    [[(IDPLabelView *)[self view] label] setText:@"PAPA"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
