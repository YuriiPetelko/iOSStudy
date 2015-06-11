//
//  NSString+IDPRandomName.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "NSString+IDPRandomName.h"

#import "NSString+IDPExtensions.h"

static const NSUInteger IDPRandomNameLength = 5;

@implementation NSString (IDPRandomName)

+ (instancetype)randomName {
    NSString *alphabet = [self lowercaseLetterAlphabet];
    
    return [[self randomStringWithLength:IDPRandomNameLength alphabet:alphabet] capitalizedString];
}

@end
