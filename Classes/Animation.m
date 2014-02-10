//
//  Animation.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/13.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "Animation.h"


@implementation Animation
+(void) setAndplay:(UIImageView *)imageview :(float)duration :(int)repeat{
	imageview.animationDuration = duration;
	imageview.animationRepeatCount = repeat;
	[imageview startAnimating];
}
+(void) setAnimationImage:(UIImageView *)imageview :(NSString *)imagename :(NSString *)type :(int)min :(int)max{
	int i;
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (i=min; i<=max; i++) {
		NSString *tmp;
		if (i<10) {
			tmp = [NSString stringWithFormat:@"%@0%d.%@",imagename,i,type];
		}else {
			tmp = [NSString stringWithFormat:@"%@%d.%@",imagename,i,type];
		}
		[array addObject:[UIImage imageNamed:tmp]];
	}
	imageview.animationImages = array;
	[array release];	 
}
@end
