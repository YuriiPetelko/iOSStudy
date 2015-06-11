//
//  IDPUsersViewController.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/11/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPUsersViewController.h"

#import "IDPUser.h"
#import "IDPUsersView.h"

#import "IDPMacro.h"

IDPViewControllerBaseViewProperty(IDPUsersViewController, usersView, IDPUsersView)

@implementation IDPUsersViewController

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = self.usersView.tableView;
    [tableView reloadData];
    
    [tableView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGRect bounds = self.usersView.tableView.bounds;

    NSLog(@"%@", [NSValue valueWithCGRect:bounds]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const kIDPCellName = @"kIDPCellName";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIDPCellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kIDPCellName];
    }
    
    cell.textLabel.text = self.user.fullName;
    
    return cell;
}

@end
