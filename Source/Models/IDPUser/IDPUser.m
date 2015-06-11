//
//  IDPUser.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPUser.h"

#import "NSString+IDPRandomName.h"

@implementation IDPUser

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = [NSString randomName];
        self.surname = [NSString randomName];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

@end
