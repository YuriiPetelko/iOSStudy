//
//  IDPFetchedResultsControllerDelegateObject.m
//  iOSProject
//
//  Created by Oleksa Korin on 7/30/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPFetchedResultsControllerDelegateObject.h"

@implementation IDPFetchedResultsControllerDelegateObject

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
//    self.user = anObject;
//    self.oldPath = indexPath;
//    self.currentPath = newIndexPath;
    self.changeType = type;
    
    NSLog(@"%@", self);
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {

}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@\nuser = %@\noldpath = %@\ncurrentPath = %@\ntype = %lu",
            [super description], self.user, self.oldPath, self.currentPath, self.changeType];
}

- (void)reset {
    self.user = nil;
    self.oldPath = nil;
    self.currentPath = nil;
    self.changeType = 0;
}

@end
