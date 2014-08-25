//
//  ViewController.m
//  Instagram
//
//  Created by Yaogang Lian on 8/24/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSEImagePicker.h"
#import "JSECoreImage.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Set up webview
    _webView.backgroundColor = [UIColor blackColor];
    _webView.opaque = YES;
    _webView.scrollView.scrollEnabled = FALSE;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    _webView.scrollView.delaysContentTouches = NO;
    _webView.scalesPageToFit = YES;
    _webView.keyboardDisplayRequiresUserAction = NO;
    _webView.mediaPlaybackRequiresUserAction = NO;
    _webView.delegate = self;
    
    // Load index.html
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"HTML"];
    NSURL *url = [NSURL fileURLWithPath:indexPath];
    //NSURL *url = [NSURL URLWithString:@"http://192.168.0.17:4000"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *ctx = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    ctx[@"JSEImagePicker"] = [JSEImagePicker class];
    ctx[@"JSECoreImage"] = [JSECoreImage class];
    
    // Create filter thumbnails
    JSECoreImage *imageConverter = [JSECoreImage create];
    UIImage *srcImage = [UIImage imageNamed:@"sunflower.png"];
    
    ctx[@"createThumbnail"] = ^(NSString *name, NSDictionary *options) {
        UIImage *converted;
        if ([name isEqualToString:@"Normal"]) {
            converted = srcImage;
        } else {
            converted = [imageConverter applyFilter:name onImage:srcImage options:options];
        }
        
        // Write to the temp directory
        NSString *docsPath = [NSTemporaryDirectory() stringByStandardizingPath];
        NSString *tempFile = [NSString stringWithFormat:@"%@/PHOTO_%@.png", docsPath, [[NSUUID UUID] UUIDString]];
        [UIImagePNGRepresentation(converted) writeToFile:tempFile atomically:YES];
        return [[NSURL fileURLWithPath:tempFile] absoluteString];
    };
    
    // Load the webapp
    [ctx evaluateScript:@"loadApp()"];
}

@end
