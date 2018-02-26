//
//  BJImageWrapper.m
//  FilePhotos
//
//  Created by ipad_kid on 2/24/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "BJImageWrapper.h"

@implementation BJImageWrapper

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [self init]) {
        _realWrapped = url;
    }
    
    return self;
}

+ (instancetype)wrapperWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

- (NSData *)realData {
    return [NSData dataWithContentsOfURL:_realWrapped];
}

@end
