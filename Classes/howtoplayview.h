//
//  howtoplayview.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/30.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackPage.h"

@interface howtoplayview : BackPage {
	int count;
	int nextcount;
	IBOutlet UIImageView *show;
	IBOutlet UIButton *nextbutton;
	IBOutlet UIImageView *fram;
	IBOutlet UIButton *lv1;
	IBOutlet UIButton *lv3;
	IBOutlet UIButton *lv4;
	IBOutlet UIImageView *bgphoto;
	
	BOOL cannext;
	int chooselevel;
	NSTimer *but;
}
@property (nonatomic, retain) UIImageView *bgphoto;
@property (nonatomic, retain) NSTimer *but;
@property (nonatomic, retain) UIImageView *fram;
@property (nonatomic) int count;
@property (nonatomic) int nextcount;
@property (nonatomic, retain) UIImageView *show;
@property (nonatomic, retain) UIButton *nextbutton;
@property (nonatomic, retain) UIButton *lv1;
@property (nonatomic, retain) UIButton *lv3;
@property (nonatomic, retain) UIButton *lv4;

-(IBAction) lv1press;
-(IBAction) lv3press;
-(IBAction) lv4press;
-(void) reload;
-(IBAction) nextpage;
@end
