//
//  JSEImagePicker.m
//  JSExport
//
//  Created by Yaogang Lian on 8/6/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import "JSEImagePicker.h"
#import <MobileCoreServices/UTCoreTypes.h>

@implementation JSEImagePicker

+ (JSEImagePicker *)create
{
    return [[JSEImagePicker alloc] init];
}

+ (BOOL)isSourceTypeAvailable:(NSString *)sourceType
{
    if (![sourceType isEqualToString:@"PhotoLibrary"] && ![sourceType isEqualToString:@"SavedPhotoAlbum"] && ![sourceType isEqualToString:@"Camera"]) {
        return NO;
    }
    
    UIImagePickerControllerSourceType sourceTypeClass = [self getSourceTypeClass:sourceType];
    if (![UIImagePickerController isSourceTypeAvailable:sourceTypeClass]) {
        return NO;
    }
    return YES;
}

+ (UIImagePickerControllerSourceType)getSourceTypeClass:(NSString *)sourceType
{
	if( [sourceType isEqualToString:@"PhotoLibrary"] ) {
		return UIImagePickerControllerSourceTypePhotoLibrary;
	} else if( [sourceType isEqualToString:@"SavedPhotosAlbum"] ) {
		return UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else if( [sourceType isEqualToString:@"Camera"] ) {
		return UIImagePickerControllerSourceTypeCamera;
	}
	return UIImagePickerControllerSourceTypePhotoLibrary;
}

- (void)getPicture:(NSDictionary *)options callback:(JSValue *)cb
{
    callback = cb;
    
    // Get current options
    NSString *sourceType = options[@"sourceType"] ? options[@"sourceType"] : @"PhotoLibrary";
    
    // Source type validation
    if (![JSEImagePicker isSourceTypeAvailable:sourceType]) {
        [callback callWithArguments:@[@"Error"]];
    }
    
    _picker = [[UIImagePickerController alloc] init];
    _picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    _picker.mediaTypes = @[(NSString *)kUTTypeImage]; // images only
    _picker.sourceType = [JSEImagePicker getSourceTypeClass:sourceType];
    _picker.delegate = self;
    
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [rootViewController presentViewController:_picker animated:YES completion:nil];
}

- (void)closePicker
{
    [_picker dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"image: %@", image);
    [callback callWithArguments:@[@"Success"]];
    [self closePicker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [callback callWithArguments:@[@"Error"]];
    [self closePicker];
}

@end
