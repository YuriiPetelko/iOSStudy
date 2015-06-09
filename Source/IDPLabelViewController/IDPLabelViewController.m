//
//  IDPLabelViewController.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPLabelViewController.h"

@interface IDPLabelViewController ()

@end

@implementation IDPLabelViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = @"MAMAMA";
    label.backgroundColor = [UIColor redColor];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    self.view.opaque = NO;
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
