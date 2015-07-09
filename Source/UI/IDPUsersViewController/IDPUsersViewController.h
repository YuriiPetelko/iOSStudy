//
//  IDPUsersViewController.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/11/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPUser;

@interface IDPUsersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   IDPUser     *user;

@end
