//
//  Waveplay.h
//  Meme
//
//  Created by LEE on 2010/4/20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackPage.h"
#import "PMusic.h"
#define levelfile @"level.plist"
#define scorefile @"score.plist"
#define Level3_Check 7000

@interface Waveplay : BackPage {
	IBOutlet UIImageView *bgphoto;
	IBOutlet UIImageView *HairView;
	IBOutlet UIImageView *BlueLineView;
	IBOutlet UIImageView *PicImageView;
	IBOutlet UIImageView *Win_Lose;
	IBOutlet UIImageView *Emotion;
	IBOutlet UIImageView *Time;
	IBOutlet UIImageView *Mouse;	
	IBOutlet UIImageView *Frame;
	IBOutlet UIImageView *Score_Frame;
	IBOutlet UIImageView *Tap;
	//IBOutlet UIImageView *Frame2;
	
	IBOutlet UIImageView *N0;
	IBOutlet UIImageView *N1;
	IBOutlet UIImageView *N2;
	IBOutlet UIImageView *N3;
	IBOutlet UIImageView *N4;
	IBOutlet UIImageView *N5;
	IBOutlet UIImageView *N6;
	IBOutlet UIImageView *N7;
	IBOutlet UIImageView *N8;
	IBOutlet UIImageView *N9;
	
	IBOutlet UIImageView *T0;
	IBOutlet UIImageView *T1;
	IBOutlet UIImageView *T2;
	
	IBOutlet UIButton *Score_Back;
	IBOutlet UIButton *Menu;
	IBOutlet UIButton *Score_Continue;
	IBOutlet UIButton *Pausebutton;
	IBOutlet UIButton *Back;
	IBOutlet UIButton *Continuebutton;
	NSTimer *ShowWinLose;	
	NSTimer *Time_Count;
	NSTimer *Score_Show;
	NSString *pic_path;
	int level;
	int cut;
	int count;
	int time_count;
	int score;
	PMusic *playmusic;
	BOOL showstart;
	IBOutlet UIButton *checkbutton;
	IBOutlet UIImageView *bubble;
	IBOutlet UIImageView *tip;
	
	UIImage *hair;
	UIImage *picimage;
	UIImage *compareimage;
 	CGImageRef inImage;	
	CGPoint firsttouch;
	CGPoint lasttouch;
	NSTimer *ShowBlueLine;
	PMusic *rightmusic;
	PMusic *wrongmusic;
}
@property (nonatomic, retain) UIButton *checkbutton;
@property (nonatomic, retain) UIImageView *bubble;
@property (nonatomic, retain) UIImageView *tip;
@property(nonatomic, retain) UIImageView *bgphoto;
@property(nonatomic, retain) UIImageView *HairView;
@property(nonatomic, retain) UIImageView *BlueLineView;
@property(nonatomic, retain) UIImageView *PicImageView;
@property(nonatomic, retain) UIImage *hair;
@property(nonatomic, retain) UIImage *picimage;
@property (nonatomic, retain) UIImage *compareimage;
@property(nonatomic) CGImageRef inImage;
@property CGPoint firsttouch;
@property CGPoint lasttouch;
@property(nonatomic, retain) NSTimer *ShowBlueLine;
@property (nonatomic, retain) UIImageView *Win_Lose;
@property (nonatomic, retain) UIImageView *Emotion;
@property (nonatomic, retain) UIImageView *Time;
@property (nonatomic, retain) UIImageView *Mouse;
@property (nonatomic, retain) UIImageView *Frame;
@property (nonatomic, retain) UIImageView *Score_Frame;
@property (nonatomic, retain) UIImageView *Tap;
//@property (nonatomic, retain) UIImageView *Frame2;
@property (nonatomic, retain) UIButton *Back;
@property (nonatomic, retain) UIButton *Continuebutton;
@property (nonatomic, retain) NSTimer *ShowWinLose;
@property (nonatomic) int level;
@property (nonatomic) int cut;
@property (nonatomic) int count;
@property (nonatomic) int time_count;
@property (nonatomic) int score;
@property (nonatomic, retain) NSTimer *Time_Count;

@property (nonatomic, retain) UIImageView *N0;
@property (nonatomic, retain) UIImageView *N1;
@property (nonatomic, retain) UIImageView *N2;
@property (nonatomic, retain) UIImageView *N3;
@property (nonatomic, retain) UIImageView *N4;
@property (nonatomic, retain) UIImageView *N5;
@property (nonatomic, retain) UIImageView *N6;
@property (nonatomic, retain) UIImageView *N7;
@property (nonatomic, retain) UIImageView *N8;
@property (nonatomic, retain) UIImageView *N9;

@property (nonatomic, retain) UIImageView *T0;
@property (nonatomic, retain) UIImageView *T1;
@property (nonatomic, retain) UIImageView *T2;

@property (nonatomic, retain) UIButton *Score_Back;
@property (nonatomic, retain) UIButton *Menu;
@property (nonatomic, retain) UIButton *Score_Continue;
@property (nonatomic, retain) UIButton *Pausebutton;
@property (nonatomic, retain) NSTimer *Score_Show;
@property (nonatomic, retain) NSString *pic_path;


-(IBAction) check;
-(IBAction) Pause;
-(IBAction) Resume;
-(IBAction) undo;
-(IBAction) menu;
-(IBAction) Continue;

- (void) reload;
- (void) draw;
- (void) PixelColorAtLocation:(CGPoint)point;
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef)BitMapImage;
- (BOOL) Compare:(CGImageRef)inImage1 TwoImage:(NSString *) CurlinImage;
- (void) loadImage:(NSString *) Bgfilepath Hair:(NSString *) Hairfilepath;
- (void) JudgeWinLose:(NSTimer *) timer; 
- (void) ShowBlueLine:(NSTimer*) timer;
- (void) Time_Count:(NSTimer *) timer;
- (void) Score_Show:(NSTimer *) timer;
-(NSString*) datafilepath;
-(NSString *) scorefilepath;
-(void) nextcut;
-(void) nextlevel;
-(void) reset;
-(void) countscore:(int) add;
@end
