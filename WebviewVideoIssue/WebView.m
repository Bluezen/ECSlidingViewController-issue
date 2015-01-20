//
//  WebView.m
//  WebviewVideoIssue
//
//  Created by Adrien Long on 09/01/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "WebView.h"
#import <WebKit/WebKit.h>
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@interface WebView ()
@property (nonatomic, strong) WKWebView *view;
@end

@implementation WebView
@dynamic view;
@synthesize url=_url;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *menuButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
     target:self
     action:@selector(menuButtonTapped:)];
    
    [self.navigationItem setLeftBarButtonItem:menuButton];
}

- (void)loadView
{
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.mediaPlaybackRequiresUserAction = NO;
    config.allowsInlineMediaPlayback = YES;
    config.preferences = [WKPreferences new];
    
    WKWebView *wv = [[WKWebView alloc] initWithFrame:screenFrame configuration:config];
    
    [self setView:wv];
}

-(void)setUrl:(NSURL *)url
{
    if (url != _url) {
        _url = url;
        
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [self.view loadRequest:req];
    }
}

- (void)menuButtonTapped:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
