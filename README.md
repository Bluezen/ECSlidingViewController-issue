# ECSlidingViewController 2.0.3 - issue
This repository is a demo of an issue with html5 videos not playing correctly in a `WKWebView` after using the pan gesture of `ECSlidingViewController` (in its `2.0.3` version).

![gif](http://cl.ly/image/3e1N2N2l341p/Screen%20Recording%202015-01-21%20at%2004.47%20PM.gif)

## Installation

You must have [cocoapods installed](http://guides.cocoapods.org/using/getting-started.html).

You must first run `pod install` in the directory of the source code then use the newly created `WebviewVideoIssue.xcworkspace` file to launch the project.

## How to reproduce the issue

1. Run the app on an **iPad** (real device or the simulator).
2. Wait a few seconds for the youtube webpage to load and to start playing the video automatically.
3. Start a pan gesture towards the right to open the menu.

* Result: The video keeps playing as we can hear the sound going on but the image froze.
* Expected result: the video keeps playing correctly.

Notes:  
* If you open the menu by touching the --Menu-- button the issue is not happening, the image of the video won't freeze. 
* The issue happens with any html5 video playing inline. Toggling the fullscreen mode will unfroze the video if launch the Apple media player. If you run this demo on an iPhone you won't see the issue as the video will automaticaly be played in fullscreen with Apple media player.
* The issue occurs only with `WKWebView`, everything is allright with `UIWebView`, you can switch the webview by touching the --Switch-- button to try it out.

## Quick fix
You can use commit [74b55f84291bc1868171888a3a7de282fff39021](https://github.com/ECSlidingViewController/ECSlidingViewController/commit/74b55f84291bc1868171888a3a7de282fff39021) as a quick fix but it has a bad side effect: it breaks the interactivity of the animation to open the menu. 

The issue has something to do with the last lines in 
```objc 
- (void)animateOperation:(ECSlidingViewControllerOperation)operation
``` 
of `ECSlidingViewController.m` but I can't get to the root of the problem. 

Instead of the commit above you could only dispatch on the main queue the following lines (at the end of 
`animateOperation:`) to get the same results:
``` objc
dispatch_async(dispatch_get_main_queue(), ^{
    if ([self isInteractive]) {
        [self.currentInteractiveTransition startInteractiveTransition:self];
    } else {
        [self.currentAnimationController animateTransition:self];
    }
});
```

Any help with a proper fix for this issue would be very appreciated!
