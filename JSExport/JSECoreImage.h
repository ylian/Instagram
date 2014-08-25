//
//  JSECoreImage.h
//  Instagram
//
//  Created by Yaogang Lian on 8/24/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class JSECoreImage;

@protocol JSECoreImageExports <JSExport>

+ (JSECoreImage *)create;

JSExportAs(applyVignetteFilter,
- (UIImage *)applyVignetteFilter:(UIImage *)srcImage withRadius:(float)inputRadius andIntensity:(float)inputIntensity
);

@end

@interface JSECoreImage : NSObject <JSECoreImageExports>

@end
