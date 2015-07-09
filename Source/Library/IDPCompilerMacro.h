//
//  IDPCompilerMacro.h
//  iOSProject
//
//  Created by Oleksa Korin on 6/17/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#define IDPClangDiagnosticPush _Pragma("clang diagnostic push")
#define IDPClangDiagnosticPop _Pragma("clang diagnostic pop")

#define IDPClangDiagnosticPushExpression(key) \
    IDPClangDiagnosticPush; \
    _Pragma(key);

#define IDPClangDiagnosticPopExpression IDPClangDiagnosticPop