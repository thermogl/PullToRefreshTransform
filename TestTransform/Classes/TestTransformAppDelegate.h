//
//  TestTransformAppDelegate.h
//  TestTransform
//
//  Created by Tom Irving on 29/10/2011.
//  Copyright (c) 2011 Tom Irving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTransformAppDelegate : UIResponder <UIApplicationDelegate> {
	
	UIWindow * window;
	UINavigationController * navigationController;
}

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *navigationController;

@end
