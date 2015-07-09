//
//  IDPUserCellBackgroundImage.m
//  iOSProject
//
//  Created by Oleksa Korin on 7/1/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPUserCellBackgroundImage.h"

#import "IDPMacro.h"

@interface IDPUserCellBackgroundImage ()
@property (nonatomic, readonly) NSString    *imageName;
@property (nonatomic, assign)   CGSize      size;

@property (nonatomic, readonly, getter=isCached) BOOL   cached;

- (UIImage *)loadImage;
- (UIImage *)drawImage;

@end

@implementation IDPUserCellBackgroundImage

@dynamic imageName;
@dynamic cached;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithSize:(CGSize)size {
    return [[self alloc] initWithSize:size];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSize:(CGSize)size {
    self = [super init];
    if (self) {
        self.size = size;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isCached {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self.url path]];
}

- (NSString *)imageName {
    return [NSString stringWithFormat:@"%@+%@@%dx",
                                        NSStringFromClass([self class]),
                                        [NSValue valueWithCGSize:self.size],
                                        (uint)[[UIScreen mainScreen] scale]];
}

- (NSURL *)url {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array firstObject];
    path = [[path stringByAppendingPathComponent:self.imageName] stringByAppendingPathExtension:@"png"];
    
    return [NSURL fileURLWithPath:path];
}

#pragma mark -
#pragma mark Public

- (void)save {
    UIImage *image = self.image;
    if (!image) {
        return;
    }
    
    if (!self.cached) {
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToURL:self.url
              atomically:YES];
    }
}

- (NSOperation *)imageLoadingOperation {
    IDPWeakify(self);
    void(^block)(void) = ^{
        IDPStrongifyAndReturnIfNil(self);
        
        self.image = [self loadImage];
        [self save];
    };
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:block];
    
    return operation;
}

#pragma mark -
#pragma mark Private

- (UIImage *)loadImage {
    if (self.cached) {
        return [UIImage imageWithContentsOfFile:[self.url path]];
    } else {
        return [self drawImage];
    }
    
    return nil;
}

- (UIImage *)drawImage {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    CGSize imageSize = self.size;
    
    CGRect frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor clearColor] setFill];
    CGContextFillRect(context, frame);
    
    [[UIColor blueColor] setFill];
    CGContextFillEllipseInRect(context, frame);
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
