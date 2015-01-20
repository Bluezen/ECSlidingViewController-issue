//
//  AppDelegate.m
//  WebviewVideoIssue
//
//  Created by Adrien Long on 09/12/2014.
//  Copyright (c) 2014 Adrien Long. All rights reserved.
//

#import "AppDelegate.h"

#import "WebView.h"

#import <ECSlidingViewController/ECSlidingViewController.h>


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self configuredRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(UIViewController *)configuredRootViewController
{
    WebView *webView = [WebView new];
    webView.url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=vSkb0kDacjs&autoplay=1"];
    
    MenuTableViewController *menuViewController = [MenuTableViewController new];
    
    
    UINavigationController *topViewController = [[UINavigationController alloc] initWithRootViewController:webView];
    
    ECSlidingViewController *slidingViewController = [ECSlidingViewController slidingWithTopViewController:topViewController];
    slidingViewController.underLeftViewController  = menuViewController;
    slidingViewController.anchorRightRevealAmount  = 270.0;
    slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGesturePanning | ECSlidingViewControllerAnchoredGestureTapping;
    

    [topViewController.view addGestureRecognizer:slidingViewController.panGesture];
    
    return slidingViewController;
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