//
//  BJImageWrapper.h
//  FilePhotos
//
//  Created by ipad_kid on 2/24/15.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJImageWrapper : UIImage

@property (nonatomic, readonly) NSString *refPath;

+ (instancetype)wrapperWithFile:(NSString *)path;

- (instancetype)initWithFile:(NSString *)path;
- (NSData *)realData;

@end
