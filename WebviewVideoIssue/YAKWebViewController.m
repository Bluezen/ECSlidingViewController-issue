//
//  WebView.m
//  WebviewVideoIssue
//
//  Created by Adrien Long on 09/01/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "YAKWebViewController.h"
#import <WebKit/WebKit.h>

@interface YAKWebViewController ()
{
    BOOL _isWkWebView;
}
@property (nonatomic, strong) UIView *view;
@end

@implementation YAKWebViewController
@dynamic view;
@synthesize url=_url;

-(id)init
{
    return [self initAsShinyNewWebView:YES];
}

-(id)initAsShinyNewWebView:(BOOL)isWKWebView
{
    self = [super init];
    if (self) {
        _isWkWebView = isWKWebView;
    }
    return self;
}

- (void)loadView
{
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    
    if (_isWkWebView) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        config.mediaPlaybackRequiresUserAction = NO;
        config.allowsInlineMediaPlayback = YES;
        config.preferences = [WKPreferences new];
        
        WKWebView *wv = [[WKWebView alloc] initWithFrame:screenFrame configuration:config];
        
        [self setView:wv];
    } else {
        UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
        wv.mediaPlaybackRequiresUserAction = NO;
        wv.allowsInlineMediaPlayback = YES;
        
        [self setView:wv];
    }
}

-(void)setUrl:(NSURL *)url
{
    if (url != _url) {
        _url = url;
        
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        SEL selector = @selector(loadRequest:);
        [self.view performSelector:selector withObject:req];
    }
}

@end
