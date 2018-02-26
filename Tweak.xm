#import "BJFilePickerController.h"
#import "BJImageWrapper.h"

@interface PUUIAlbumListViewController : UIViewController
@end

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

%hookf(NSData *, UIImagePNGRepresentation, BJImageWrapper *image) {
    if ([image isKindOfClass:BJImageWrapper.class]) {
        return image.realData;
    }
    
    return %orig;
}

%hookf(NSData *, UIImageJPEGRepresentation, BJImageWrapper *image, CGFloat compressionQuality) {
    if ([image isKindOfClass:BJImageWrapper.class]) {
        return image.realData;
    }
    
    return %orig;
}
