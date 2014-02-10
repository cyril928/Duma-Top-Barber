//
//  BackPage.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/12.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMusic.h"
#import "Animation.h"

@interface BackPage : UIViewController {
	IBOutlet UIButton *backbutton;
	BOOL enablesound;
}
@property (nonatomic, retain) UIButton *backbutton;
@property (nonatomic) BOOL enablesound;

-(IBAction) back;
-(void) playclick;

@end
