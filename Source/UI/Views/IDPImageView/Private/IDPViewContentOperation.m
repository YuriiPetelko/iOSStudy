//
//  IDPViewContentOperation.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/24/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPViewContentOperation.h"

static NSString * const kIDPViewContentOperationContext = @"kIDPViewContentOperationContext";

@interface IDPViewContentOperation ()
@property (nonatomic, weak)     id          model;
@property (nonatomic, weak)     id          view;
@property (nonatomic, copy)     NSString    *viewModelKeyPath;

- (void)addObserverForSelector:(SEL)selector;
- (void)removeObserverForSelector:(SEL)selector;

- (void)addObservers;
- (void)removeObservers;

- (void)startModelObservation;
- (void)stopModelObservation;

@end

@implementation IDPViewContentOperation

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self removeObservers];
}

- (instancetype)initWithModel:(id)model
                         view:(id)view
             viewModelKeyPath:(id)viewModelKeyPath
{
    self = [super init];
    if (self) {
        self.model = model;
        self.view = view;
        self.viewModelKeyPath = viewModelKeyPath;
        [self addObservers];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)invalidate {
    self.state = IDPViewContentOperationInvalid;
}

- (void)execute {
    NSObject *view = self.view;
    id model = [view valueForKey:self.viewModelKeyPath];
    if (self.model == model) {
        IDPModelGetContent contentGetter = self.contentGetter;
        IDPViewSetContent contentSetter = self.contentSetter;
        
        if (contentSetter && contentGetter) {
            id content = contentGetter(model);
            contentSetter(view, content);
        }
    }
}

#pragma mark -
#pragma mark Private

- (void)startModelObservation {
    NSString *keyPath = self.viewModelKeyPath;
    NSObject *view = self.view;
    if (keyPath && view) {
        [view addObserver:self
               forKeyPath:keyPath
                  options:NSKeyValueObservingOptionNew
                  context:(__bridge void *)(kIDPViewContentOperationContext)];
    }
}

- (void)stopModelObservation {
    NSString *keyPath = self.viewModelKeyPath;
    NSObject *view = self.view;
    if (keyPath && view) {
        [view removeObserver:self
                  forKeyPath:keyPath
                     context:(__bridge void *)(kIDPViewContentOperationContext)];
    }
}

- (void)addObservers {
    [self startModelObservation];
    [self addObserverForSelector:@selector(model)];
    [self addObserverForSelector:@selector(view)];
}

- (void)removeObservers {
    [self stopModelObservation];
    [self removeObserverForSelector:@selector(model)];
    [self removeObserverForSelector:@selector(view)];
}

- (void)addObserverForSelector:(SEL)selector {
    [self addObserver:self
           forKeyPath:NSStringFromSelector(selector)
              options:NSKeyValueObservingOptionNew
              context:(__bridge void *)(kIDPViewContentOperationContext)];
}

- (void)removeObserverForSelector:(SEL)selector {
    [self removeObserver:self
              forKeyPath:NSStringFromSelector(selector)
                 context:(__bridge void *)(kIDPViewContentOperationContext)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(model))]
        || [keyPath isEqualToString:NSStringFromSelector(@selector(view))]
        || ([keyPath isEqualToString:self.viewModelKeyPath]
            && change[NSKeyValueChangeNewKey] != self.model))
    {
        self.state = IDPViewContentOperationInvalid;
    }
}

@end
