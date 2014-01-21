//
//  TDProgressBarController.m
//  DropDownTable
//
//  Created by Abby Schlageter on 17/01/2014.
//  Copyright (c) 2014 Abby Schlageter. All rights reserved.
//

#import "TDProgressBarController.h"

@implementation TDProgressBarController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    
	// we need to set the subview dimensions or it will not always render correctly
	// http://stackoverflow.com/questions/1088163
	for (UIView* subview in self.progressView.subviews) {
		subview.frame = self.progressView.bounds;
	}
}

-(BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setToolbar:nil];
    [super viewDidUnload];
    
	self.progressView = nil;
	self.delegate = nil;
    
}
@end
