//
//  DBUser.h
//  iOSProject
//
//  Created by Oleksa Korin on 7/21/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DBImage;
@class DBUser;

@interface DBUser : NSManagedObject
@property (nonatomic, strong)   NSString      *name;
@property (nonatomic, strong)   NSString      *surname;
@property (nonatomic, readonly) NSString      *fullName;

@property (nonatomic, assign)   NSUInteger    age;
@property (nonatomic, assign)   BOOL          married;

@property (nonatomic, strong)   NSSet         *images;
@property (nonatomic, strong)   NSSet         *friends;

@end

@interface DBUser (CoreDataGeneratedAccessors)

- (void)addImage:(DBImage *)value;
- (void)removeImage:(DBImage *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addFriend:(DBUser *)value;
- (void)removeFriend:(DBUser *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

@end
