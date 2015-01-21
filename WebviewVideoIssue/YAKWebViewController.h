//
//  WebView.h
//  WebviewVideoIssue
//
//  Created by Adrien Long on 09/01/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YAKWebViewController : UIViewController

@property (nonatomic, strong) NSURL *url;

-(id)initAsShinyNewWebView:(BOOL)isWKWebView;

@end
