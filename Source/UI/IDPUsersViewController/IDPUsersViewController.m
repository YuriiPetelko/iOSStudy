//
//  IDPUsersViewController.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/11/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPUsersViewController.h"

#import "ActiveRecordKit.h"

#import "IDPUserViewController.h"

#import "DBUser.h"
#import "IDPFetchedResultsControllerDelegateObject.h"

#import "IDPUser.h"
#import "IDPUsersView.h"
#import "IDPUserCell.h"

#import "IDPMacro.h"

#import "NSString+IDPRandomName.h"

IDPViewControllerBaseViewProperty(IDPUsersViewController, usersView, IDPUsersView)

@interface IDPUsersViewController ()
@property (nonatomic, strong)   NSFetchedResultsController  *controller;
@property (nonatomic, strong)   IDPFetchedResultsControllerDelegateObject   *delegate;

@end

@implementation IDPUsersViewController

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.usersView.tableView reloadData];
    
    self.title = @"Users";
    
    [IDPCoreDataManager sharedManagerWithMomName:@"iOSProject"];
    
    for (NSUInteger index = 0; index < 10; index++) {
        DBUser *user = [DBUser managedObject];
        user.name = [NSString randomName];
        user.surname = [NSString randomName];
        user.age = arc4random_uniform(100);
        user.married = arc4random_uniform(2);
    }
    
    [NSManagedObjectContext saveManagedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([DBUser class])];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]];
    
    NSManagedObjectContext *context = [[IDPCoreDataManager sharedManager] managedObjectContext];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                 managedObjectContext:context
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:nil];
    self.controller = controller;
    
    IDPFetchedResultsControllerDelegateObject *delegate = [IDPFetchedResultsControllerDelegateObject new];
    controller.delegate = delegate;
    self.delegate = delegate;
    
    NSError *error = nil;
    [controller performFetch:&error];
    NSLog(@"%@", error);
    
    DBUser *user = [controller.fetchedObjects firstObject];
    
    user.surname = @"Jewbacca";
    user.age = 500;
    user.married = NO;
    [context save:nil];
    
    user.name = @"Manchester";
    [context save:nil];
    
    [context deleteObject:user];
    [context save:nil];

    user = [DBUser managedObject];
    [user saveManagedObject];
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

#pragma mark -
#pragma mark UITableViewDelegate

- (void)    tableView:(UITableView *)tableView
 didEndDisplayingCell:(IDPUserCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.user = nil;
}

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IDPUserCell *cell = (IDPUserCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    IDPUser *user = cell.user;
    
    IDPUserViewController *controller = [IDPUserViewController new];
    controller.user = user;

    [self.navigationController pushViewController:controller animated:YES];
//    [self presentViewController:controller animated:YES completion:nil];
}

#define IDPOutputMethod NSLog(@"%@", NSStringFromSelector(_cmd));

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    IDPOutputMethodWithScrollView
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    IDPOutputMethodWithScrollView
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    IDPOutputMethodWithScrollView
//}
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    IDPOutputMethodWithScrollView
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    IDPOutputMethodWithScrollView
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    IDPOutputMethodWithScrollView
//}
//
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
//    IDPOutputMethodWithScrollView
//}

@end
