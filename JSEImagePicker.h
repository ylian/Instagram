//
//  JSEImagePicker.h
//  JSExport
//
//  Created by Yaogang Lian on 8/6/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class JSEImagePicker;

@protocol JSEImagePickerExports <JSExport>

+ (JSEImagePicker *)create;

JSExportAs(getPicture,
- (void)getPicture:(NSDictionary *)options callback:(JSValue *)callback
);

@end

@interface JSEImagePicker : NSObject <JSEImagePickerExports, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    JSValue *callback;
}

@property (nonatomic, strong) UIImagePickerController *picker;

@end
