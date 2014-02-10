//
//  Start.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/1.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMusic.h"
#import "MainController.h"
#define levelfile @"level.plist"
#define switchfile @"soundswitch.plist"
#define scorefile @"score.plist"
#define howtofile @"howto.plist"

@interface Start : UIViewController {
	int count;
	int startcount;
	NSTimer *button;
	NSTimer *photo;
	PMusic *click;
	IBOutlet UIImageView *lite;
	IBOutlet UIImageView *startpage;
	IBOutlet UIButton *startbutton;
	MainController *mainpage;
}
@property (nonatomic, retain) UIImageView *lite;
@property (nonatomic, retain) NSTimer *button;
@property (nonatomic, retain) NSTimer *photo;
@property (nonatomic) int startcount;
@property (nonatomic) int count;
@property (nonatomic, retain) UIImageView *startpage;
@property (nonatomic, retain) UIButton *startbutton;
@property (nonatomic, retain) MainController *mainpage;

-(NSString*) datafilepathlv;
-(NSString*) datafilepathsd;
-(NSString *) datafilepathscore;

-(void) initfile;
-(IBAction) pressstart;
-(void) reload;
-(void) playclick;
@end
