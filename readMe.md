## FilePhotos

**Not ready.** *Attempt* at choosing any file (from filesystem) from the stock iOS image picker.

Below is the only delegate method for UIImagePickerControllerDelegate we need to deal with
It contains example code on how someone would normally parse out data on iOS 10.2 (the `info` dictionary may be different on different iOS versions)
The correct tweak only supports UIImages. If the picked file is an image, a UIImage is created and sent back. If the file is not an image, a UIImage subclass called `BJImageWrapper` is created with the file information
Similar to how `BJImageWrapper` works, pseudo classes will be created and parsed on relevant methods and functions. All callback information should be filled out appropriately, to avoid app crashes, and the best user experience

```objc
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    NSLog(@"%@", info);
    /* {
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x17408bef0> size {2448, 3264} orientation 3 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=9B161C11-45D7-4E40-9BC8-9EF91DC9F849&ext=JPG";
     } */
    
    NSURL *ref = info[UIImagePickerControllerReferenceURL];
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsWithALAssetURLs:@[ref] options:NULL];
    
    [PHImageManager.defaultManager requestImageForAsset:result.firstObject targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:NULL resultHandler:^(UIImage *result, NSDictionary *info) {
        NSLog(@"%@", info);
        /* {
         PHImageFileSandboxExtensionTokenKey = "a0791bcdef86dd1b4717a6360169d0e8abdf5acd;00000000;00000000;000000000000001a;com.apple.app-sandbox.read;00000001;01000004;000000000022be6a;/private/var/mobile/Media/DCIM/100APPLE/IMG_0176.JPG";
         PHImageFileURLKey = "file:///var/mobile/Media/DCIM/100APPLE/IMG_0176.JPG";
         PHImageResultDeliveredImageFormatKey = 9999;
         PHImageResultIsDegradedKey = 0;
         PHImageResultIsInCloudKey = 0;
         PHImageResultIsPlaceholderKey = 0;
         PHImageResultOptimizedForSharing = 0;
         PHImageResultRequestIDKey = 66;
         PHImageResultWantedImageFormatKey = 9999;
         } */
    }];
    
    [PHImageManager.defaultManager requestImageDataForAsset:result.firstObject options:NULL resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
        NSLog(@"%@", info);
        /* {
         PHImageFileOrientationKey = 0;
         PHImageFileSandboxExtensionTokenKey = "a0791bcdef86dd1b4717a6360169d0e8abdf5acd;00000000;00000000;000000000000001a;com.apple.app-sandbox.read;00000001;01000004;000000000022be6a;/private/var/mobile/Media/DCIM/100APPLE/IMG_0176.JPG";
         PHImageFileURLKey = "file:///var/mobile/Media/DCIM/100APPLE/IMG_0176.JPG";
         PHImageFileUTIKey = "public.jpeg";
         PHImageResultDeliveredImageFormatKey = 9999;
         PHImageResultIsDegradedKey = 0;
         PHImageResultIsInCloudKey = 0;
         PHImageResultIsPlaceholderKey = 0;
         PHImageResultOptimizedForSharing = 0;
         PHImageResultRequestIDKey = 65;
         PHImageResultWantedImageFormatKey = 9999;
         } */
    }];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
```
