//
//  IDPARCObject.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/8/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPARCObject : NSObject {
    __weak id object;
}

@property (nonatomic, strong)               id  strongObject;
@property (nonatomic, weak)                 id  weakObject;
@property (nonatomic, unsafe_unretained)    id  assignObject;

- (void)execute;

@end
