//
//  BJImageWrapper.m
//  FilePhotos
//
//  Created by ipad_kid on 2/24/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "BJImageWrapper.h"

@implementation BJImageWrapper

- (instancetype)initWithPath:(NSString *)path {
    if (self = [self init]) {
        _realWrapped = path;
    }
    
    return self;
}

+ (instancetype)wrapperWithPath:(NSString *)path {
    return [[self alloc] initWithPath:path];
}

- (NSData *)realData {
    return [NSData dataWithContentsOfFile:_realWrapped];
}

@end
