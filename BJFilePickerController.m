//
//  BJFilePickerController.m
//  FilePhotos
//
//  Created by ipad_kid on 10/4/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "BJFilePickerController.h"

@implementation BJFilePickerController {
    NSArray *filesAtPath;
    NSInteger filesCount;
}

static NSString *cellIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.currentPath) self.currentPath = @"/";
    filesAtPath = [NSFileManager.defaultManager contentsOfDirectoryAtPath:self.currentPath error:NULL];
    filesCount = filesAtPath.count;
    self.navigationItem.title = self.currentPath.lastPathComponent;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filesCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *dirObject = filesAtPath[indexPath.row];
    NSString *fullPath = [self.currentPath stringByAppendingPathComponent:dirObject];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
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
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
