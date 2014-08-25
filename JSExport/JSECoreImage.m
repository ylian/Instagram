//
//  JSECoreImage.m
//  Instagram
//
//  Created by Yaogang Lian on 8/24/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import "JSECoreImage.h"

@implementation JSECoreImage

+ (JSECoreImage *)create
{
    return [[JSECoreImage alloc] init];
}

- (UIImage *)applyFilter:(NSString *)name onImage:(UIImage *)srcImage options:(NSDictionary *)options
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter= [CIFilter filterWithName:name];
    CIImage *inputImage = [[CIImage alloc] initWithImage:srcImage];
    [filter setValue:inputImage forKey:@"inputImage"];
    
    for (NSString *key in options) {
        [filter setValue:options[key] forKey:key];
    }
    
    CGImageRef imageRef = [context createCGImage:[filter outputImage] fromRect:filter.outputImage.extent];
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:srcImage.scale orientation:srcImage.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}

- (NSString *)applyFilter:(NSString *)name onImagePath:(NSString *)srcPath options:(NSDictionary *)options
{
    UIImage *srcImage = [UIImage imageWithContentsOfFile:srcPath];
    UIImage *converted = [self applyFilter:name onImage:srcImage options:options];
    
    // Write to the temp directory and return the imageURI
    NSString *docsPath = [NSTemporaryDirectory() stringByStandardizingPath];
    NSString *tempFile = [NSString stringWithFormat:@"%@/PHOTO_%@.png", docsPath, [[NSUUID UUID] UUIDString]];
    [UIImagePNGRepresentation(converted) writeToFile:tempFile atomically:YES];
    return [[NSURL fileURLWithPath:tempFile] absoluteString];
}

@end
