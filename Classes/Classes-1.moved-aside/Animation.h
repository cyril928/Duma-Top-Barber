//
//  Animation.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/13.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface Animation : NSObject {
	UIImageView *tmpimageview;
}
-(id) initWithImageView:(UIImageView *)imageview;
-(void) setAnimationImage:(NSString *)imagename :(NSString *)type : (int)min :(int)max;
-(void) setAnimation:(float)duration;

@end
