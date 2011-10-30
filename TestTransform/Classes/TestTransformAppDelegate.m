//
//  TestTransformAppDelegate.m
//  TestTransform
//
//  Created by Tom Irving on 29/10/2011.
//  Copyright (c) 2011 Tom Irving. All rights reserved.
//

#import "TestTransformAppDelegate.h"
#import "TestTransformViewController.h"

@implementation TestTransformAppDelegate
@synthesize window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	TestTransformViewController * viewController = [[TestTransformViewController alloc] init];
	navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	[viewController release];
	
	[self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	
    return YES;
}

- (void)dealloc {
	[window release];
	[navigationController release];
    [super dealloc];
}

@end
