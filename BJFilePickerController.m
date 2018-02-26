//
//  BJFilePickerController.m
//  FilePhotos
//
//  Created by ipad_kid on 10/4/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "BJFilePickerController.h"
#import "BJImageWrapper.h"

#define kCellIdentifier @"Cell"

@implementation BJFilePickerController {
    NSArray *filesAtPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_currentPath) {
        _currentPath = @"/";
    }
    
    filesAtPath = [NSFileManager.defaultManager contentsOfDirectoryAtPath:_currentPath error:NULL];
    
    self.navigationItem.title = _currentPath.lastPathComponent;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filesAtPath.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *dirObject = filesAtPath[indexPath.row];
    NSString *fullPath = [self.currentPath stringByAppendingPathComponent:dirObject];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = dirObject;
    
    BOOL isDir;
    [NSFileManager.defaultManager fileExistsAtPath:fullPath isDirectory:&isDir];
    cell.accessoryType = isDir ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *fullPath = [self.currentPath stringByAppendingPathComponent:cell.textLabel.text];
    
    BOOL isDir;
    [NSFileManager.defaultManager fileExistsAtPath:fullPath isDirectory:&isDir];
    if (isDir) {
        BJFilePickerController *newViewController = [BJFilePickerController new];
        newViewController.currentPath = fullPath;
        [self.navigationController pushViewController:newViewController animated:YES];
    } else {
        UIImagePickerController *imagePicker = (UIImagePickerController *)self.parentViewController;
        id<UIImagePickerControllerDelegate> imagePickerDelegate = imagePicker.delegate;
        
        if ([imagePickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
            NSURL *returningURL = [NSURL fileURLWithPath:fullPath];
            NSDictionary<NSString *, id> *info;
            
            UIImage *imageRet = [UIImage imageWithContentsOfFile:fullPath];
            info = @{
                     UIImagePickerControllerMediaType: (imageRet ? @"public.image" : @"public.file"),
                     UIImagePickerControllerOriginalImage: (imageRet ?: [BJImageWrapper wrapperWithURL:returningURL]),
                     UIImagePickerControllerReferenceURL: returningURL
                     };
            [imagePickerDelegate imagePickerController:imagePicker didFinishPickingMediaWithInfo:info];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
