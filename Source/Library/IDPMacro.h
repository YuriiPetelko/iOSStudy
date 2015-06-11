//
//  IDPMacro.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/11/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#define IDPDefineBaseViewProperty(propertyName, viewClass) \
    @property (nonatomic, readonly) viewClass   *propertyName;

#define IDPBaseViewGetterSynthesize(selector, viewClass) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define IDPViewControllerBaseViewProperty(viewControllerClass, propertyName, baseViewClass) \
    @interface viewControllerClass (__IDPPrivateBaseView) \
    IDPDefineBaseViewProperty(propertyName, baseViewClass) \
    \
    @end \
    \
    @implementation viewControllerClass (__IDPPrivateBaseView) \
    \
    @dynamic propertyName; \
    \
    IDPBaseViewGetterSynthesize(propertyName, baseViewClass) \
    \
    @end
