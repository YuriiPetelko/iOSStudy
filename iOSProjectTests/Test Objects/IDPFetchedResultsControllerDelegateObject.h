//
//  IDPFetchedResultsControllerDelegateObject.h
//  iOSProject
//
//  Created by Oleksa Korin on 7/30/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DBUser;

@interface IDPFetchedResultsControllerDelegateObject : NSObject <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong)   NSIndexPath                 *oldPath;
@property (nonatomic, strong)   NSIndexPath                 *currentPath;
@property (nonatomic, assign)   NSFetchedResultsChangeType  changeType;
@property (nonatomic, strong)   DBUser                      *user;

- (void)reset;

@end
