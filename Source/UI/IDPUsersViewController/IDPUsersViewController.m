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
#import "IDPUserCell.h"

#import "IDPMacro.h"

IDPViewControllerBaseViewProperty(IDPUsersViewController, usersView, IDPUsersView)

@implementation IDPUsersViewController

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.usersView.tableView reloadData];
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
    NSString *cellClass = NSStringFromClass([IDPUserCell class]);
    
    IDPUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClass];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:cellClass bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        cell = [cells firstObject];
    }
    
    cell.user = [IDPUser new];
    
    return cell;
}

@end
