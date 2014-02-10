//
//  Option.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/12.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackPage.h"
#import "howtoplayview.h"

#define switchfile @"soundswitch.plist"

@interface Option : BackPage {
	NSString *filepath;
	IBOutlet UIButton *howtoplay;
	IBOutlet UISlider *volume;
	howtoplayview *howto;
	BOOL sound;
	BOOL vib;
	IBOutlet UIButton *soundon;
	IBOutlet UIButton *soundoff;
	IBOutlet UIButton *vibrationon;
	IBOutlet UIButton *vibrationoff;
	
	IBOutlet UISlider *clickvolume;
	IBOutlet UISlider *playvolume;
	
	int howcount;
	IBOutlet UIImageView *frame;
	NSTimer *howtotimer;
}
@property (nonatomic, retain) UISlider *clickvolume;
@property (nonatomic, retain) UISlider *playvolume;
@property (nonatomic, retain) NSTimer *howtotimer;
@property (nonatomic) BOOL sound;
@property (nonatomic) BOOL vib;
@property (nonatomic) int howcount;
@property (nonatomic, retain) UIImageView *frame;
@property (nonatomic, retain) UISlider *volume;
@property (nonatomic, retain) howtoplayview *howto;
@property (nonatomic, retain) UIButton *howtoplay;
@property (nonatomic, retain) UIButton *soundon;
@property (nonatomic, retain) UIButton *soundoff;
@property (nonatomic, retain) UIButton *vibrationon;
@property (nonatomic, retain) UIButton *vibrationoff;

-(NSString*) datafilepath;
-(IBAction) presssoundon;
-(IBAction) presssoundoff;
-(IBAction) pressvibon;
-(IBAction) pressviboff;

-(void) reload;
-(void) save;
-(void) reloadswitch;
-(IBAction) howtopress;
-(IBAction) clickvolumechange;
-(IBAction) playvolumechange;

@end
