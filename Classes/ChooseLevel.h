//
//  ChooseLevel.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/12.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackPage.h"
#import "PlayView.h"
#define levelfile @"level.plist"
#define howtofile @"howto.plist"
#import "Catchplay.h"
#import "Waveplay.h"

@interface ChooseLevel : BackPage {
	NSString *filepath;
	IBOutlet UIButton *level1;
	IBOutlet UIButton *level2;
	IBOutlet UIButton *level3;
	IBOutlet UIButton *level4;
	
	PlayView *playcontroller;
	Catchplay *catchplay;
	Waveplay *waveplay;
	IBOutlet UISlider *lvchange;
	IBOutlet UILabel  *debuglv;
	IBOutlet UIImageView *frame;
	IBOutlet UIImageView *line;
	IBOutlet UIImageView *level;
	IBOutlet UIImageView *hw;
	IBOutlet UIImageView *hwbg;
	IBOutlet UIButton *nextbutton;
	NSTimer *nexttimer;
	int nextcount;
	int chlv;
	int presscount;
}
@property (nonatomic, retain) UIButton *nextbutton;
@property (nonatomic, retain) Catchplay *catchplay;
@property (nonatomic, retain) Waveplay *waveplay;
@property (nonatomic, retain) UIImageView *frame;
@property (nonatomic, retain) UIImageView *line;
@property (nonatomic, retain) UIImageView *level;
@property (nonatomic, retain) UIImageView *hw;
@property (nonatomic, retain) UIImageView *hwbg;
@property (nonatomic, retain) UIButton *level1;
@property (nonatomic, retain) UIButton *level2;
@property (nonatomic, retain) UIButton *level3;
@property (nonatomic, retain) UIButton *level4;
@property (nonatomic, retain) PlayView *playcontroller;

@property (nonatomic, retain) UISlider *lvchange;
@property (nonatomic, retain) UILabel  *debuglv;

-(void) reload;
-(NSString*) datafilepath;
-(NSString*) howto;
-(void) reloadlevel;
-(IBAction) changelv;
-(IBAction) playlv1;
//-(IBAction) playlv2;
-(IBAction) playlv3;
-(IBAction) playlv4;
-(IBAction) nextpress;

@end