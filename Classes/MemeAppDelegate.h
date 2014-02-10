//
//  MemeAppDelegate.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/5.
//  Copyright Nation Taiwan University 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

