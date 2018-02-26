//
//  BJAssetWrapper.m
//  FilePhotos
//
//  Created by ipad_kid on 2/26/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "BJAssetWrapper.h"

@implementation BJAssetWrapper

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [self init]) {
        _realWrapped = url;
    }
    
    return self;
}

+ (instancetype)assetWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

- (NSData *)realData {
    return [NSData dataWithContentsOfURL:_realWrapped];
}

@end
