//
//  IDPImageModelDispatcher.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/16/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPImageModelDispatcher : NSObject
@property (nonatomic, readonly)     NSOperationQueue    *queue;

+ (instancetype)sharedDispatcher;

@end
