//
//  BJImageWrapper.h
//  FilePhotos
//
//  Created by ipad_kid on 2/24/18.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJImageWrapper : UIImage

@property (nonatomic, readonly) NSString *realWrapped;

+ (instancetype)wrapperWithPath:(NSString *)path;
- (NSData *)realData;

@end
