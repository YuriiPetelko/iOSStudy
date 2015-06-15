//
//  IDPUser.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/9/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IDPUser : NSObject
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, copy)     NSString    *surname;
@property (nonatomic, readonly) NSString    *fullName;
@property (nonatomic, readonly) UIImage     *image;

@end
