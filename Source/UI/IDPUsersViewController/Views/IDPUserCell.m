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
    
    static dispatch_once_t onceToken;
    static dispatch_queue_t queue = nil;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("mama", DISPATCH_QUEUE_SERIAL);
    });
    
    dispatch_async(queue, ^{
        UIImage *image = user.image;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userImageView.contentImageView.image = image;
        });
    });
}

@end
