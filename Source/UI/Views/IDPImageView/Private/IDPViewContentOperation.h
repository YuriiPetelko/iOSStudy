//
//  IDPViewContentOperation.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/24/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObservableObject.h"

typedef id(^IDPModelGetContent)(id model);
typedef void(^IDPViewSetContent)(id view, id content);

typedef NS_ENUM(NSUInteger, IDPViewContentOperationState) {
    IDPViewContentOperationValid,
    IDPViewContentOperationInvalid
};

@interface IDPViewContentOperation : IDPObservableObject
@property (nonatomic, weak, readonly)   id                  model;
@property (nonatomic, weak, readonly)   id                  view;
@property (nonatomic, copy)             IDPModelGetContent  contentGetter;
@property (nonatomic, copy)             IDPViewSetContent   contentSetter;
@property (nonatomic, copy, readonly)   NSString            *viewModelKeyPath;

- (instancetype)initWithModel:(id)model
                         view:(id)view
             viewModelKeyPath:(id)viewModelKeyPath;

- (void)execute;
- (void)invalidate;

@end
