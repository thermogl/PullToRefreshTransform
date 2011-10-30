//
//  TestTransformViewController.h
//  TestTransform
//
//  Created by Tom Irving on 29/10/2011.
//  Copyright (c) 2011 Tom Irving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTransformViewController : UITableViewController {
	
	UIView * headerView;
	
	UIView * topView;
	UIView * bottomView;
	
	UILabel * topLabel;
	UILabel * bottomLabel;
	
	BOOL refreshing;
}

@end
