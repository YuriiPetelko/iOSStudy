//
//  IDPActiveRecordSpec.m
//  iOSProject
//
//  Created by Oleksa Korin on 7/27/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "Kiwi.h"

#import "DBUser.h"
#import "DBImage.h"

#import "IDPFetchedResultsControllerDelegateObject.h"

#import "ActiveRecordKit.h"

#import "NSString+IDPRandomName.h"
#import "NSFileManager+IDPExtensions.h"

SPEC_BEGIN(IDPActiveRecordSpec)

NSUInteger entityCount = 10;

beforeAll(^{
    NSError *error = nil;
    
    NSString *dbPath = [[NSFileManager applicationDataPath] stringByAppendingPathComponent:@"iOSProjectStore.sqlite"];
    [[NSFileManager defaultManager] removeItemAtPath:dbPath error:&error];
    
    [IDPCoreDataManager sharedManagerWithMomName:@"iOSProject"];
});

void(^createUsers)(void) = ^{
    for (NSUInteger index = 0; index < entityCount; index++) {
        DBUser *user = [DBUser managedObject];
        user.name = [NSString randomName];
        user.surname = [NSString randomName];
        user.age = arc4random_uniform(100);
        user.married = arc4random_uniform(2);
    }
};

__block NSManagedObjectContext *customContext = nil;

NSArray *(^fetchUsersFromCustomContext)(void) = ^{
    if (!customContext) {
        customContext = [[NSManagedObjectContext alloc] init];
        customContext.persistentStoreCoordinator = [[IDPCoreDataManager sharedManager] persistentStoreCoordinator];
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([DBUser class])];
    request.returnsObjectsAsFaults = YES;
    
    NSError *error = nil;
    
    return [customContext executeFetchRequest:request error:&error];
};

describe(@"DBUser", ^{
    context(@"when inserted into NSManagedObjectContext", ^{
        beforeAll(^{
            createUsers();
        });
        
        it(@"users should be present in current context", ^{
            NSArray *users = [DBUser fetchEntityWithSortDescriptors:nil
                                                          predicate:nil
                                                      prefetchPaths:nil];
            
            [[users should] haveCountOf:entityCount];
        });
        
        it(@"users shouldn't be present in custom context", ^{
            NSArray *users = fetchUsersFromCustomContext();
            [[users should] haveCountOf:0];
        });
        
        context(@"after saving current context", ^{
            beforeAll(^{
                [NSManagedObjectContext saveManagedObjectContext];
            });
            
            it(@"10 users should be present in custom context", ^{
                NSArray *users = fetchUsersFromCustomContext();
                [[users should] haveCountOf:10];
            });
            
            context(@"when fetching users from current context and custom context", ^{
                __block NSArray *customContextUsers = nil;
                __block NSArray *currentContextUsers = nil;
                
                beforeAll(^{
                    customContextUsers = fetchUsersFromCustomContext();
                    currentContextUsers = [DBUser fetchEntityWithSortDescriptors:nil
                                                                       predicate:nil
                                                                   prefetchPaths:nil];
                });
                
                it(@"objects should differ", ^{
                    BOOL value = YES;
                    NSUInteger count = 0;
                    
                    for (NSUInteger index = 0; index < entityCount; index++) {
                        id currentObject = currentContextUsers[index];
                        id customObject = customContextUsers[index];
                        
                        BOOL isEqual = currentObject == customObject;
                        value = value && isEqual;
                        count += isEqual ? 1 : 0;
                    }
                    
                    [[theValue(count) shouldNot] equal:theValue(entityCount)];
                    [[theValue(value) should] equal:theValue(NO)];
                });
                
                it(@"objects ID's should equal", ^{
                    BOOL value = YES;
                    NSUInteger count = 0;
                    
                    for (NSUInteger index = 0; index < entityCount; index++) {
                        id currentObject = currentContextUsers[index];
                        id customObject = customContextUsers[index];
                        
                        BOOL isEqual = [[currentObject objectID] isEqualToId:[customObject objectID]];
                        value = value && isEqual;
                        count += isEqual ? 1 : 0;
                    }
                    
                    [[theValue(count) should] equal:theValue(entityCount)];
                    [[theValue(value) should] equal:theValue(YES)];
                });
            });
        });
        
        context(@"when adding DBImage", ^{
            __block DBUser *user = nil;
            
            beforeEach(^{
                user = [[DBUser fetchEntityWithSortDescriptors:nil
                                                     predicate:nil
                                                 prefetchPaths:nil] firstObject];
            });
            
            afterEach(^{
                [NSManagedObjectContext resetManagedObjectContext];
            });
            
            it(@"image should contain it, when added in direct relation", ^{
                DBImage *image = [DBImage managedObject];
                [user addImage:image];
                
                [[image.user should] equal:user];
            });
            
            it(@"it should contain image, when added in inverse relation", ^{
                DBImage *image = [DBImage managedObject];
                image.user = user;
                
                [[user.images should] contain:image];
            });
        });
        
        context(@"when adding friends", ^{
            __block DBUser *user = nil;
            __block NSArray *users = nil;
            
            beforeEach(^{
                users = [DBUser fetchEntityWithSortDescriptors:nil
                                                     predicate:nil
                                                 prefetchPaths:nil];
                user = [users firstObject];
                
                for (DBUser *entity in users) {
                    entity.friends = [NSSet setWithArray:users];
                }
                
                NSLog(@"%@", users);
            });
            
            afterEach(^{
                [NSManagedObjectContext resetManagedObjectContext];
            });
            
            it(@"its friends count should equal all users count", ^{
                [[user.friends should] haveCountOf:[users count]];
            });
            
            it(@"it should contain all users in DB", ^{
                [[user.friends should] equal:[NSSet setWithArray:users]];
            });
            
            it(@"it should delete all users, when friend relation is cascade deleted", ^{
                [user deleteManagedObject];
                
                NSArray *usersAfterDelete = [DBUser fetchEntityWithSortDescriptors:nil
                                                                         predicate:nil
                                                                     prefetchPaths:nil];
                
                [[usersAfterDelete should] haveCountOf:0];
            });
        });
        
        context(@"when fetching using NSFetchedResultsController", ^{
            __block NSFetchedResultsController *controller = nil;
            __block IDPFetchedResultsControllerDelegateObject *delegate = nil;
            
            beforeAll(^{
                createUsers();
                delegate = [IDPFetchedResultsControllerDelegateObject new];
                
                [NSManagedObjectContext saveManagedObjectContext];
                
                NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([DBUser class])];
                request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]];
                
                NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
                context.persistentStoreCoordinator = [[IDPCoreDataManager sharedManager] persistentStoreCoordinator];
                
                controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                 managedObjectContext:context
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
                
                controller.delegate = delegate;
                
                NSError *error = nil;
                [controller performFetch:&error];
                NSLog(@"%@", error);
            });
            
            it(@"controller should contain entityCount users", ^{
                [[controller.fetchedObjects should] haveCountOf:entityCount];
            });
            
            it(@"controller should notify, when object is changed", ^{
                DBUser *user = [controller.fetchedObjects firstObject];
                
                user.name = @"Manchester";
                user.surname = @"Jewbacca";
                user.age = 500;
                user.married = NO;
                
                [user saveManagedObject];
                
                [[delegate.user shouldNotEventually] beNil];
            });
        });
    });
});

SPEC_END
