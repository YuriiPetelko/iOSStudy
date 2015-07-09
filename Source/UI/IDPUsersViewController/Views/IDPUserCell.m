//
//  IDPUserCell.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/15/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPUserCell.h"

#import "IDPUser.h"

#import "IDPImageView.h"

#import "IDPUserCellBackgroundImage.h"

@implementation IDPUserCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundImageView.imageModel = [IDPUserCellBackgroundImage imageWithSize:self.bounds.size];
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(IDPUser *)user {
    if (_user != user) {
        _user = user;
        
        [self fillWithModel:user];
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(IDPUser *)user {
    self.fullNameLabel.text = user.fullName;
    self.userImageView.imageModel = user.imageModel;
}

@end
