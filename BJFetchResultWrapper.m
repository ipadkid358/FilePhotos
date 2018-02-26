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
    BJAssetWrapper *realObject;
}

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [self init]) {
        realObject = [BJAssetWrapper assetWithURL:url];
    }
    
    return self;
}

+ (instancetype)resultWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

- (id)firstObject {
    return realObject;
}

- (id)lastObject {
    return realObject;
}

- (NSUInteger)count {
    return 1;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index == 1) {
        return realObject;
    }
    
    return NULL;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx == 1) {
        return realObject;
    }
    
    return NULL;
}

@end
