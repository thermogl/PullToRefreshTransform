//
//  TestTransformViewController.m
//  TestTransform
//
//  Created by Tom Irving on 29/10/2011.
//  Copyright (c) 2011 Tom Irving. All rights reserved.
//

#import "TestTransformViewController.h"
#import <QuartzCore/QuartzCore.h>

CGFloat const kRefreshViewHeight = 65;

@interface TestTransformViewController (Private)
- (void)unfoldHeaderToFraction:(CGFloat)fraction;
- (void)refreshData;
@end

@implementation TestTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationItem setTitle:@"Example"];
	
	headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -kRefreshViewHeight, self.view.bounds.size.width, kRefreshViewHeight)];
	[headerView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	[self.tableView addSubview:headerView];
	[headerView release];
	
	CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
	[headerView.layer setSublayerTransform:transform];
	
	topView = [[UIView alloc] initWithFrame:CGRectMake(0, -kRefreshViewHeight / 4, headerView.bounds.size.width, kRefreshViewHeight / 2)];
	[topView setBackgroundColor:[UIColor colorWithRed:0.886 green:0.906 blue:0.929 alpha:1]];
	[topView.layer setAnchorPoint:CGPointMake(0.5, 0.0)];
	[headerView addSubview:topView];
	[topView release];
	
	topLabel = [[UILabel alloc] initWithFrame:topView.bounds];
	[topLabel setBackgroundColor:[UIColor clearColor]];
	[topLabel setTextAlignment:UITextAlignmentCenter];
	[topLabel setText:@"Pull down to refresh"];
	[topLabel setTextColor:[UIColor colorWithRed:0.395 green:0.427 blue:0.510 alpha:1]];
	[topLabel setShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7]];
	[topLabel setShadowOffset:CGSizeMake(0, 1)];
	[topView addSubview:topLabel];
	[topLabel release];
	
	bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kRefreshViewHeight * 3 / 4, headerView.bounds.size.width, kRefreshViewHeight / 2)];
	[bottomView setBackgroundColor:[UIColor colorWithRed:0.836 green:0.856 blue:0.879 alpha:1]];
	[bottomView.layer setAnchorPoint:CGPointMake(0.5, 1.0)];
	[headerView addSubview:bottomView];
	[bottomView release];
	
	bottomLabel = [[UILabel alloc] initWithFrame:bottomView.bounds];
	[bottomLabel setBackgroundColor:[UIColor clearColor]];
	[bottomLabel setText:@"Last updated: 1/11/13 8:41 PM"];
	[bottomLabel setTextAlignment:UITextAlignmentCenter];
	[bottomLabel setTextColor:[UIColor colorWithRed:0.395 green:0.427 blue:0.510 alpha:1]];
	[bottomLabel setShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7]];
	[bottomLabel setShadowOffset:CGSizeMake(0, 1)];
	[bottomView addSubview:bottomLabel];
	[bottomLabel release];
	
	// Just so it's not white above the refresh view.
	UIView * aboveView = [[UIView alloc] initWithFrame:CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - kRefreshViewHeight)];
	[aboveView setBackgroundColor:[UIColor colorWithRed:0.886 green:0.906 blue:0.929 alpha:1]];
	[aboveView setTag:123];
	[self.tableView addSubview:aboveView];
	[aboveView release];
	
	refreshing = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	[UIView animateWithDuration:duration animations:^{
		[headerView setFrame:CGRectMake(0, -kRefreshViewHeight, self.view.bounds.size.width, kRefreshViewHeight)];
		[topView setFrame:CGRectMake(0, -kRefreshViewHeight / 4, headerView.bounds.size.width, kRefreshViewHeight / 2)];
		[bottomView setFrame:CGRectMake(0, (kRefreshViewHeight / 2), headerView.bounds.size.width, kRefreshViewHeight / 2)];
		[topLabel setFrame:topView.bounds];
		[bottomLabel setFrame:bottomView.bounds];
		[[self.view viewWithTag:123] setFrame:CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - kRefreshViewHeight)];
	}];
}

- (void)refreshData {
	
	refreshing = YES;
	
	[topLabel setText:@"Refreshing..."];
	[UIView animateWithDuration:0.2 animations:^{[self.tableView setContentInset:UIEdgeInsetsMake(kRefreshViewHeight, 0, 0, 0)];}];
	
	double delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^{
		refreshing = NO;
		[UIView animateWithDuration:0.2 animations:^{[self.tableView setContentInset:UIEdgeInsetsZero];}];
	});
}

- (void)unfoldHeaderToFraction:(CGFloat)fraction {
	[bottomView.layer setTransform:CATransform3DMakeRotation((M_PI / 2) - asinf(fraction), 1, 0, 0)];
	[topView.layer setTransform:CATransform3DMakeRotation(asinf(fraction) + (((M_PI) * 3) / 2) , 1, 0, 0)];
	[topView setFrame:CGRectMake(0, kRefreshViewHeight * (1 - fraction), self.view.bounds.size.width, kRefreshViewHeight / 2)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString * CellIdentifier = @"Cell";
	
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	[cell.textLabel setText:@"Row"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (!refreshing){
		
		CGFloat fraction = scrollView.contentOffset.y / -kRefreshViewHeight;
		if (fraction < 0) fraction = 0;
		if (fraction > 1) fraction = 1;
		
		[self unfoldHeaderToFraction:fraction];
		
		if (fraction == 1)[topLabel setText:@"Release to refresh"];
		else [topLabel setText:@"Pull down to refresh"];
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if (scrollView.contentOffset.y < -kRefreshViewHeight) [self refreshData];
}

@end
