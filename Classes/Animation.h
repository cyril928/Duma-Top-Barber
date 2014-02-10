//
//  Animation.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/13.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Animation : NSObject {

}
+(void) setAnimationImage:(UIImageView*)imageview:(NSString*)imagename:(NSString*)type:(int)min:(int)max;
+(void) setAndplay:(UIImageView*)imageview:(float)duration:(int)repeat;
@end
