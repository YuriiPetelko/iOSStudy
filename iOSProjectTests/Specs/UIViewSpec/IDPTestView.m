//
//  IDPTestView.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/17/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPTestView.h"

@implementation IDPTestView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.coder = coder;
    }
    
    return self;
}

@end
