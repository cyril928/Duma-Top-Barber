//
//  PlayView.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/17.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackPage.h"
#import "Type.h"
#import "View.h"
#define levelfile @"level.plist"
#define scorefile @"score.plist"

#define Level1_Check 5000
#define Level2_Check 5000



@interface PlayView: BackPage {
	UIImage *bgimage;
	UIImage *syimage;
	UIImage *garbage;
	UIImage *compareimage;
	IBOutlet View *pview;
	IBOutlet UIImageView *imageView;
	IBOutlet UIImageView *Win_Lose;
	IBOutlet UIImageView *Emotion;
	IBOutlet UIImageView *Time;
	IBOutlet UIImageView *Mouse;	
	IBOutlet UIImageView *Frame;
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
	
	IBOutlet UIButton *Back;
	IBOutlet UIButton *Continuebutton;
	IBOutlet UIButton *Score_Back;
	IBOutlet UIButton *Menu;
	IBOutlet UIButton *Score_Continue;
	IBOutlet UIButton *Pausebutton;
	NSTimer *ShowWinLose;
	NSTimer *Time_Count;
	NSTimer *Score_Show;
	NSString *pic_path;
	int level;
	int cut;
	int count;
	int count1;
	int time_count;
	PMusic *playmusic;
	PMusic *rightmusic;
	PMusic *wrongmusic;
	BOOL showstart;
	int score;
	
	//int readline;
}
@property (nonatomic, retain) UIImage *syimage;
@property (nonatomic, retain) UIImage *compareimage;
@property (nonatomic, retain) UIView *pview;
@property (nonatomic) int level;
@property (nonatomic) int cut;
@property (nonatomic) int count;
@property (nonatomic) int count1;
@property (nonatomic) int time_count;
@property (nonatomic) int score;
//@property (nonatomic) int readline;
@property (nonatomic, retain) UIImage *bgimage;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImageView *Win_Lose;
@property (nonatomic, retain) UIImageView *Emotion;
@property (nonatomic, retain) UIImageView *Time;
@property (nonatomic, retain) UIImageView *Mouse;
@property (nonatomic, retain) UIImageView *Frame;
@property (nonatomic, retain) UIImageView *Tap;
//@property (nonatomic, retain) UIImageView *Frame2;

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


@property (nonatomic, retain) UIButton *Back;
@property (nonatomic, retain) UIButton *Continuebutton;
@property (nonatomic, retain) UIButton *Score_Back;
@property (nonatomic, retain) UIButton *Menu;
@property (nonatomic, retain) UIButton *Score_Continue;
@property (nonatomic, retain) UIButton *Pausebutton;
@property (nonatomic, retain) NSTimer *ShowWinLose;
@property (nonatomic, retain) NSTimer *Time_Count;
@property (nonatomic, retain) NSTimer *Score_Show;
@property (nonatomic, retain) NSString *pic_path;

-(IBAction) check;
-(IBAction) Pause;
-(IBAction) Resume;
-(IBAction) undo;
-(IBAction) Continue;


-(void) setlv:(int)lv;
-(void) reload;
-(void) loadImage:(NSString *) Bgfilepath Hair:(NSString *) Hairfilepath;
-(BOOL) Compare:(CGImageRef) inImage TwoImage:(NSString *) CutfinImage;
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage;
//- (void) ShowWinLose:(NSString*) filepath;
- (void) JudgeWinLose:(NSTimer *) timer; 
- (void) Time_Count:(NSTimer *) timer;
- (void) Score_Show:(NSTimer *) timer;
-(NSString*) datafilepath;
-(NSString *) scorefilepath;
-(void) nextcut;
-(void) nextlevel;
-(void) reset;
-(void) countscore:(int) add;
@end
