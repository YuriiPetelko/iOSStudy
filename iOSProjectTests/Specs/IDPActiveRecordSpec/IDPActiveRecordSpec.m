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

describe(@"NSManagedObject", ^{
    context(@"when inserting into NSManagedObjectContext", ^{
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
                it(@"objects should differ", ^{
                    NSArray *customContextUsers = fetchUsersFromCustomContext();
                    NSArray *currentContextUsers = [DBUser fetchEntityWithSortDescriptors:nil
                                                                                predicate:nil
                                                                            prefetchPaths:nil];
                    
                    BOOL value = YES;
                    NSUInteger count = 0;
                    
                    for (NSUInteger index = 0; index < entityCount; index++) {
                        id currentObject = currentContextUsers[index];
                        [currentObject name];
                        
                        id customObject = customContextUsers[index];
                        NSLog(@"%@", [customObject name]);
                        
                        BOOL isEqual = currentObject == customObject;
                        value = value && isEqual;
                        count += isEqual ? 1 : 0;
                    }
                    
                    [[theValue(count) shouldNot] equal:theValue(entityCount)];
                    [[theValue(value) should] equal:theValue(NO)];
                });
            });
        });
    });
});

SPEC_END
