//
//  MemeAppDelegate.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/5.
//  Copyright Nation Taiwan University 2010. All rights reserved.
//

#import "MemeAppDelegate.h"

@implementation MemeAppDelegate

@synthesize window;
@synthesize navController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	srand(time(NULL));
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO]; 
    // Override point for customization after application launch
	[window makeKeyAndVisible];
	[window addSubview:navController.view];
}


- (void)dealloc {
	[navController release];
    [window release];
    [super dealloc];
}


@end
