//
//  DBImage.h
//  iOSProject
//
//  Created by Oleksa Korin on 7/21/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DBUser;

@interface DBImage : NSManagedObject
@property (nonatomic, strong)   NSString    *path;
@property (nonatomic, strong)   DBUser      *user;

@end
