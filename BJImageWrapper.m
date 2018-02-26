//
//  BJImageWrapper.m
//  FilePhotos
//
//  Created by ipad_kid on 2/24/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "BJImageWrapper.h"

@implementation BJImageWrapper

+ (instancetype)wrapperWithFile:(NSString *)path {
    return [[self alloc] initWithFile:path];
}

- (instancetype)initWithFile:(NSString *)path {
    if (self = [self init]) {
        _refPath = path;
    }
    
    return self;
}

- (NSData *)realData {
    return [NSData dataWithContentsOfFile:_refPath];
}

@end
