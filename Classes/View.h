//
//  View.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/17.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Type.h"
#import "PMusic.h"
@interface View : UIView {
	UIImageView *drawImage;
	UIImageView *picImageview;
	UIImage *picImage;
	CGImageRef inImage;
	CGRect redrawRect;
	ShapeType shapetype;
	IBOutlet UIImageView *bgphoto;
	IBOutlet UIImageView *Body;
	IBOutlet UIImageView *Hair;
	IBOutlet UIImageView *Redline;
	IBOutlet UIImageView *Tap;
	UIImage *body;
	UIImage *hair;
	UIImage *line;
	CGPoint firsttouch;
	CGPoint lasttouch;
	CGPoint currenttouch;
	CGPoint BeginPoint;
	CGPoint EndPoint;
	UIColor *FrontColor;
	UIColor *NowColor;
	UIColor *HairColor;
	NSTimer *ShowRedLine;
	int step;
	float a;
	float b;			
	int readline;
	int level;
	int cut;
	int count;
	BOOL end_redline;
	IBOutlet UIButton *checkbutton;
	IBOutlet UIImageView *bubble;
	IBOutlet UIImageView *tip;
	
	IBOutlet UIImageView *scissor;
	NSTimer *Scissor_Move;
	PMusic *cutmusic;
}
@property (nonatomic, retain) UIButton *checkbutton;
@property (nonatomic, retain) UIImageView *bubble;
@property (nonatomic, retain) UIImageView *tip;
@property (nonatomic, retain) UIImageView *scissor;
@property (nonatomic, retain) NSTimer *Scissor_Move;
@property ShapeType shapetype;
@property CGPoint firsttouch;
@property CGPoint lasttouch;
@property CGPoint currenttouch;
@property CGPoint BeginPoint;
@property CGPoint EndPoint;
@property (nonatomic, retain) UIImageView *picImageview;
@property (nonatomic, retain) UIImageView *drawImage;
@property (nonatomic, retain) UIImage *picImage;
@property (nonatomic, retain) UIImageView *bgphoto;
@property (nonatomic, retain) UIImageView *Body;
@property (nonatomic, retain) UIImageView *Hair;
@property (nonatomic, retain) UIImageView *Redline;
@property (nonatomic, retain) UIImageView *Tap;
@property (nonatomic) CGImageRef inImage;
@property (nonatomic, retain) NSTimer *ShowRedLine;
@property (nonatomic) int level;
@property (nonatomic) int cut;
@property (nonatomic) int readline;
@property (nonatomic) int count;
@property (nonatomic) BOOL end_redline;
@property (nonatomic, retain) PMusic *cutmusic;
//-(void) draw;

- (void) CutHairStart:(CGPoint)Begin CutHairEnd:(CGPoint)End;
- (void) ProcessImageStart:(CGPoint)start End:(CGPoint)end HighOrLow:(CutType)cuttype; 
- (UIColor*) PixelColorAtLocation:(CGPoint)point;
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef)BitMapImage;
- (void) ShowRedLine:(NSTimer*) timer;


@end
