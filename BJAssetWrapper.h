//
//  BJAssetWrapper.h
//  FilePhotos
//
//  Created by ipad_kid on 2/26/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface BJAssetWrapper : PHAsset

@property (nonatomic, readonly) NSString *realWrapped;

+ (instancetype)assetWithPath:(NSString *)path;
- (NSData *)realData;

@end
