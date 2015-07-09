//
//  IDPTableViewCell.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/15/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPTableViewCell.h"

@implementation IDPTableViewCell

#pragma mark -
#pragma mark Accessors

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
