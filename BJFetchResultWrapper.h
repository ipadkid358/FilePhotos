//
//  BJFetchResultWrapper.h
//  FilePhotos
//
//  Created by ipad_kid on 2/26/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface BJFetchResultWrapper<ObjectType> : PHFetchResult

+ (instancetype)resultWithPath:(NSString *)path;

@end
