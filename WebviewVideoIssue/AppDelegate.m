//
//  AppDelegate.m
//  WebviewVideoIssue
//
//  Created by Adrien Long on 09/12/2014.
//  Copyright (c) 2014 Adrien Long. All rights reserved.
//

#import "AppDelegate.h"

#import "YAKWebViewController.h"

#import <ECSlidingViewController/ECSlidingViewController.h>
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self configuredRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(UIViewController *)configuredRootViewController
{
    UIViewController *menuViewController = [MenuTableViewController new];
    
    UIViewController *topViewController = [MainNaviguationController new];
    
    UINavigationController *wrapperNavigationController = [[UINavigationController alloc] initWithRootViewController:topViewController];
    
    ECSlidingViewController *slidingViewController = [ECSlidingViewController slidingWithTopViewController:wrapperNavigationController];
    slidingViewController.underLeftViewController  = menuViewController;
    slidingViewController.anchorRightRevealAmount  = 270.0;
    slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGesturePanning | ECSlidingViewControllerAnchoredGestureTapping;
    

    [topViewController.view addGestureRecognizer:slidingViewController.panGesture];
    
    return slidingViewController;
}

@end


@implementation MainNaviguationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setIsWKWebView:YES];
    
    UIBarButtonItem *menuButton =
    [[UIBarButtonItem alloc]
     initWithTitle:@"Menu" style:UIBarButtonItemStylePlain
     target:self
     action:@selector(menuButtonTapped:)];
    
    [self.navigationItem setLeftBarButtonItem:menuButton];
    
    UIBarButtonItem *switchButton =
    [[UIBarButtonItem alloc]
     initWithTitle:@"Switch" style:UIBarButtonItemStylePlain
     target:self
     action:@selector(switchButtonTapped:)];
    
    [self.navigationItem setRightBarButtonItem:switchButton];
}

-(void)setIsWKWebView:(BOOL)isWKWebView
{
    for (UIViewController *vc in self.childViewControllers) {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
    
    YAKWebViewController *webView = [[YAKWebViewController alloc] initAsShinyNewWebView:isWKWebView];
    webView.url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=vSkb0kDacjs&autoplay=1"];
    
    [self addChildViewController:webView];
    [self.view addSubview:webView.view];
    [webView didMoveToParentViewController:self];
    
    if (isWKWebView) {
        [self.navigationItem setTitle:@"WKWebView"];
    } else {
        [self.navigationItem setTitle:@"UIWebView"];
    }
}

- (void)menuButtonTapped:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)switchButtonTapped:(id)sender
{
    YAKWebViewController *vc = self.childViewControllers.firstObject;
    if ([vc.view isKindOfClass:[UIWebView class]]) {
        [self setIsWKWebView:YES];
    } else {
        [self setIsWKWebView:NO];
    }
}

@end


@implementation MenuTableViewController
static NSString *tableViewCellReuseId = @"reuseID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellReuseId];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseId forIndexPath:indexPath];
    
    [cell.textLabel setText:@"Label"];
    
    return cell;
}
@end