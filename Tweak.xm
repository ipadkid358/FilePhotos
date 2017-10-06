#import "BJFilePickerController.h"
#define PUSHFILEPICKER _pushFilePicker

@interface PUUIAlbumListViewController : UIViewController
@end

%hook UIImagePickerController

%new
- (void)PUSHFILEPICKER {
    [self pushViewController:[BJFilePickerController new] animated:YES];
}

%end

%hook PUUIAlbumListViewController

- (void)updateNavigationBarAnimated:(BOOL)animated {
	%orig(animated);

	UIBarButtonItem *fileButton = [UIBarButtonItem new];
	fileButton.title = @"File";
	fileButton.target = self.navigationController;
	fileButton.action = @selector(PUSHFILEPICKER);
	self.navigationItem.leftBarButtonItem = fileButton;
}

%end
