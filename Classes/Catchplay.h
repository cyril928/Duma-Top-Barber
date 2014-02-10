//
//  Catchplay.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/7.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackPage.h"
#import "PMusic.h"
#define scorefile @"score.plist"
#define kUpdateInterval               (1.0f/10.0f)

@interface Catchplay : BackPage <UIAccelerometerDelegate> {
	IBOutlet UIImageView *pic01;
	IBOutlet UIImageView *pic02;
	IBOutlet UIImageView *pic03;
	IBOutlet UIImageView *pic04;
	IBOutlet UIImageView *pic05;
	IBOutlet UIImageView *pic06;
	IBOutlet UIImageView *duma;
	IBOutlet UIImageView *hair;
	IBOutlet UIImageView *tips;
	IBOutlet UIImageView *item0;
	IBOutlet UIImageView *item1;
	IBOutlet UIImageView *item2;
	IBOutlet UIImageView *item3;
	IBOutlet UIImageView *item4;
	IBOutlet UIImageView *cane;
	IBOutlet UIImageView *coloritem;
	IBOutlet UIImageView *cake;
	IBOutlet UIImageView *line;
	
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
	IBOutlet UIImageView *Frame;
	IBOutlet UIImageView *Score_Frame;
	IBOutlet UIButton *Score_Continue;
	NSString *pic_path;
	NSTimer *Score_Show;
	
	NSMutableArray *dropingphoto;
	NSMutableArray *dropingname;
	
	UIImageView *picarray[7];
	UIImageView *item[5];
	
	int style;
	int finalcolorcount;
	int finalcolor[2];
	int color[2];
	int finalitemcount;
	int finalitem[5];
	int a[7];
	int distancex[5];
	int colorchoose;
	int direction;
	
	int level[4];
	
	PMusic *playmusic;
	
	int min;
	int second;
	IBOutlet UIImageView *min1;
	IBOutlet UIImageView *second1;
	IBOutlet UIImageView *second0;
	
	
	NSTimer *time;
	NSTimer *dropitem;
	NSTimer *dropcolor;
	BOOL pausebool;
	
	int winpagecount;
	
	int randomfix[5];
	int totalrandomfix;
	
	NSTimer *pictimer,*colortimer;
	int dumapace;
	IBOutlet UIImageView *pausepage;
	IBOutlet UIButton *resumebutton;
	IBOutlet UIButton *Pausebutton;
	int score;
	PMusic *rightmusic;
}
@property (nonatomic, retain) UIImageView *line;
@property (nonatomic, retain) UIImageView *pausepage;
@property (nonatomic, retain) UIImageView *min1;
@property (nonatomic, retain) UIImageView *second1;
@property (nonatomic, retain) UIImageView *second0;
@property (nonatomic, retain) UIButton *resumebutton;
@property (nonatomic, retain) UIButton *Pausebutton;
@property (nonatomic, retain) NSTimer *dropitem;
@property (nonatomic, retain) NSTimer *dropcolor;
@property (nonatomic, retain) UIImageView *coloritem;
@property (nonatomic, retain) UIImageView *cane;
@property (nonatomic, retain) NSTimer *time;
@property (nonatomic, retain) UIImageView *cake;
@property (nonatomic, retain) UIImageView *item0;
@property (nonatomic, retain) UIImageView *item1;
@property (nonatomic, retain) UIImageView *item2;
@property (nonatomic, retain) UIImageView *item3;
@property (nonatomic, retain) UIImageView *item4;
@property (nonatomic, retain) UIImageView *tips;
@property (nonatomic, retain) UIImageView *hair;
@property (nonatomic, retain) UIImageView *duma;
@property (nonatomic, retain) UIImageView *pic01;
@property (nonatomic, retain) UIImageView *pic02;
@property (nonatomic, retain) UIImageView *pic03;
@property (nonatomic, retain) UIImageView *pic04;
@property (nonatomic, retain) UIImageView *pic05;
@property (nonatomic, retain) UIImageView *pic06;
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
@property (nonatomic, retain) UIImageView *Frame;
@property (nonatomic, retain) UIImageView *Score_Frame;
@property (nonatomic, retain) UIButton *Score_Continue;
@property (nonatomic, retain) NSTimer *Score_Show;
@property (nonatomic, retain) NSString *pic_path;
@property (nonatomic) int score;


-(IBAction) Continue;
- (void) Score_Show:(NSTimer *) timer;

-(void) checkcorrect;
-(void) cgcolor:(int)tmp;
-(void) cghair:(int)t;
-(void) setstyle:(int)st;
-(void) restart;
-(IBAction) Pause;
-(IBAction) Resume;
-(NSString *) scorefilepath;
-(void) countscore:(int) add;
@end
