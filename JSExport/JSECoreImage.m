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

- (UIImage *)applyVignetteFilter:(UIImage *)srcImage withRadius:(float)inputRadius andIntensity:(float)inputIntensity
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter= [CIFilter filterWithName:@"CIVignette"];
    CIImage *inputImage = [[CIImage alloc] initWithImage:srcImage];
    
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:inputIntensity] forKey:@"inputIntensity"];
    [filter setValue:[NSNumber numberWithFloat:inputRadius] forKey:@"inputRadius"];
    
    CGImageRef imageRef = [context createCGImage:[filter outputImage] fromRect:filter.outputImage.extent];
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:srcImage.scale orientation:srcImage.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}

@end
