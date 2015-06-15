//
//  IDPUserCell.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/15/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPTableViewCell.h"

@class IDPUser;

@interface IDPUserCell : IDPTableViewCell
@property (nonatomic, strong)   IBOutlet UILabel        *fullNameLabel;
@property (nonatomic, strong)   IBOutlet UIImageView    *userImageView;

@property (nonatomic, strong)   IDPUser     *user;

- (void)fillWithModel:(IDPUser *)user;

@end
