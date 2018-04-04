//
//  BJAssetWrapper.m
//  FilePhotos
//
//  Created by ipad_kid on 2/26/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "BJAssetWrapper.h"

@implementation BJAssetWrapper

- (instancetype)initWithPath:(NSString *)path {
    if (self = [self init]) {
        _realWrapped = path;
    }
    
    return self;
}

+ (instancetype)assetWithPath:(NSString *)path {
    return [[self alloc] initWithPath:path];
}

- (NSData *)realData {
    return [NSData dataWithContentsOfFile:_realWrapped];
}

@end
