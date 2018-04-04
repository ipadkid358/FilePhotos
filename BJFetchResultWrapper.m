//
//  BJFetchResultWrapper.m
//  FilePhotos
//
//  Created by ipad_kid on 2/26/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "BJFetchResultWrapper.h"
#import "BJAssetWrapper.h"

@implementation BJFetchResultWrapper {
    BJAssetWrapper *_realObject;
}

- (instancetype)initWithPath:(NSString *)path {
    if (self = [self init]) {
        _realObject = [BJAssetWrapper assetWithPath:path];
    }
    
    return self;
}

+ (instancetype)resultWithPath:(NSString *)path {
    return [[self alloc] initWithPath:path];
}

- (id)firstObject {
    return _realObject;
}

- (id)lastObject {
    return _realObject;
}

- (NSUInteger)count {
    return 1;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index == 1) {
        return _realObject;
    }
    
    return NULL;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx == 1) {
        return _realObject;
    }
    
    return NULL;
}

@end
