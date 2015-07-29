//
//  DBUser.m
//  iOSProject
//
//  Created by Oleksa Korin on 7/21/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "DBUser.h"
#import "DBImage.h"

#import "IDPObjCRuntime.h"

#import "NSManagedObject+IDPExtensions.h"

@implementation DBUser

@dynamic name;
@dynamic surname;
@dynamic fullName;
@dynamic age;
@dynamic married;
@dynamic images;
@dynamic friends;

#pragma mark -
#pragma mark Lifetime

- (void)awakeFromFetch {
    [super awakeFromFetch];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (void)setAge:(NSUInteger)age {
    [self setCustomValue:@(age) forKey:IDPStringFromSEL(age)];
}

- (NSUInteger)age {
    return [[self customValueForKey:IDPStringFromSEL(age)] unsignedIntegerValue];
}

- (void)addImage:(DBImage *)value {
    [self addCustomValue:value inMutableSetForKey:IDPStringFromSEL(images)];
}

- (void)removeImage:(DBImage *)value {
    [self removeCustomValue:value inMutableSetForKey:IDPStringFromSEL(images)];
}

- (void)addFriend:(DBUser *)value {
    [self addCustomValue:value inMutableSetForKey:IDPStringFromSEL(friends)];
}

- (void)removeFriend:(DBUser *)value {
    [self removeCustomValue:value inMutableSetForKey:IDPStringFromSEL(friends)];
}

@end
