#import "BJFilePickerController.h"
#import "BJImageWrapper.h"
#import "BJAssetWrapper.h"
#import "BJFetchResultWrapper.h"

@interface PUUIAlbumListViewController : UIViewController
@end

// add button listener
%hook UIImagePickerController

%new
- (void)_pushFilePicker {
    [self pushViewController:[BJFilePickerController new] animated:YES];
}

%end

%hook PUUIAlbumListViewController

- (void)updateNavigationBarAnimated:(BOOL)animated {
    %orig;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"File" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(_pushFilePicker)];
}

%end

// swizzling PHFetchResults
%hook PHAsset

+ (PHFetchResult<PHAsset *> *)fetchAssetsWithALAssetURLs:(NSArray<NSURL *> *)assetURLs options:(PHFetchOptions *)options {
    if (assetURLs.count == 1) {
        NSURL *target = assetURLs.firstObject;
        if ([target.scheme isEqualToString:@"file"]) {
            return [BJFetchResultWrapper resultWithPath:target.path];
        }
    }
    
    return %orig;
}

%end


%hook PHImageManager

// PHAsset to UIImage
- (PHImageRequestID)requestImageForAsset:(BJAssetWrapper *)asset targetSize:(CGSize)targetSize contentMode:(PHImageContentMode)contentMode options:(PHImageRequestOptions *)options resultHandler:(void (^)(UIImage *result, NSDictionary *info))resultHandler {
    if ([asset isKindOfClass:BJAssetWrapper.class]) {
        NSString *filePath = asset.realWrapped;
        BJImageWrapper *fakeImage = [BJImageWrapper wrapperWithPath:filePath];
        
        NSDictionary *returnInfo = @{
             @"PHImageFileURLKey" : [NSURL fileURLWithPath:filePath],
             @"PHImageResultIsPlaceholderKey" : @NO,
             @"PHImageResultOptimizedForSharing" : @YES,
             
             // required keys
             PHImageResultIsDegradedKey : @NO,
             PHImageResultIsInCloudKey : @NO,
             PHImageResultRequestIDKey : @(0)
         };
        
        resultHandler(fakeImage, returnInfo);
        return 0;
    }
    
    return %orig;
}

// PHAsset to NSData
- (PHImageRequestID)requestImageDataForAsset:(BJAssetWrapper *)asset options:(PHImageRequestOptions *)options resultHandler:(void(^)(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info))resultHandler {
    if ([asset isKindOfClass:BJAssetWrapper.class]) {
        // https://developer.apple.com/library/content/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html
        NSString *utiKey = @"public.data";
        UIImageOrientation orientationKey = 0;
        
        NSDictionary *returnInfo = @{
             @"PHImageFileURLKey" : [NSURL fileURLWithPath:asset.realWrapped],
             @"PHImageResultIsPlaceholderKey" : @NO,
             @"PHImageResultOptimizedForSharing" : @YES,
             
             // data specific
             @"PHImageFileOrientationKey" : @(orientationKey),
             @"PHImageFileUTIKey" : utiKey,
             
             // required keys
             PHImageResultIsDegradedKey : @NO,
             PHImageResultIsInCloudKey : @NO,
             PHImageResultRequestIDKey : @(0)
        };
        
        resultHandler(asset.realData, utiKey, orientationKey, returnInfo);
        return 0;
    }
    
    return %orig;
}

%end

// UIImage to NSData
%hookf(NSData *, UIImagePNGRepresentation, BJImageWrapper *image) {
    if ([image isKindOfClass:BJImageWrapper.class]) {
        return image.realData;
    }
    
    return %orig;
}

// This hook currently results in SpringBoard failing to load
// %hookf(NSData *, UIImageJPEGRepresentation, BJImageWrapper *image, CGFloat compressionQuality) {
//     if ([image isKindOfClass:BJImageWrapper.class]) {
//         return image.realData;
//     }
//
//     return %orig;
// }

