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

JSExportAs(applyFilter,
- (UIImage *)applyFilter:(NSString *)name onImage:(UIImage *)srcImage options:(NSDictionary *)options
);

@end

@interface JSECoreImage : NSObject <JSECoreImageExports>

@end
