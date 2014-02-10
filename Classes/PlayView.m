//
//  PlayView.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/17.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "PlayView.h"
#import "ChooseLevel.h"
#import "View.h"

@implementation PlayView
@synthesize imageView;
@synthesize Win_Lose;
@synthesize Frame;
@synthesize Tap;
//@synthesize Frame2;
@synthesize Continuebutton;
@synthesize Score_Continue;
@synthesize Back;
@synthesize Score_Back;
@synthesize Pausebutton;
@synthesize Menu;
@synthesize bgimage;
@synthesize level;
@synthesize cut;
@synthesize count;
@synthesize count1;
@synthesize time_count;
@synthesize score;
@synthesize pview;
@synthesize syimage;
@synthesize compareimage;
@synthesize Emotion;
@synthesize Time;
@synthesize Mouse;
@synthesize ShowWinLose;
@synthesize Time_Count;
@synthesize N1;
@synthesize N2;
@synthesize N3;
@synthesize N4;
@synthesize N5;
@synthesize N6;
@synthesize N7;
@synthesize N8;
@synthesize N9;
@synthesize N0;
@synthesize T0;
@synthesize T1;
@synthesize T2;
@synthesize pic_path;
@synthesize Score_Show;

- (void) setlv:(int)lv {
	level = lv;
}
- (void) loadTimer {	
	if (level == 1) {
		[Animation setAndplay:Emotion :5 :0];
		//[Animation setAndplay:Mouse :6.25 :0];
		Time_Count = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Time_Count:) userInfo:nil repeats:YES];	
	}
	else if(level == 2)	{ 
		[Animation setAndplay:Emotion :5 :0];
		//[Animation setAndplay:Mouse :10 :0];
		Time_Count = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Time_Count:) userInfo:nil repeats:YES];				
	}				
}	

- (void) ShowLevel {
	[Frame stopAnimating];
	Win_Lose.image = nil;
	if(cut == 1) {
		time_count = 60;
		if (level == 1) {
			[Animation setAnimationImage:Emotion :@"emo_lv1_00" :@"png" :1 :3];	
		}
		else if(level == 2) {
			[Animation setAnimationImage:Emotion :@"emo_lv2_00" :@"png" :1 :3];
		}
		//Time.image = [UIImage imageNamed:@"level_time_0001.png"];
		T0.image = [UIImage imageNamed:@"time_nb_1.png"];
		T1.image = [UIImage imageNamed:@"time_nb_0.png"];
		T2.image = [UIImage imageNamed:@"time_nb_0.png"];	
		[self loadTimer];	
	}
}
- (void) reload {
	
	if(cut == 1 && showstart && level !=3){			
		showstart = NO;
		NSLog(@"hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhx");
		Win_Lose.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv%d_1_start.png",level]];
		[Animation setAnimationImage:Frame :@"lv1_1_start_line_" :@"png" :1 :2];
		[Animation setAndplay:Frame :0.5 :0];
		[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(ShowLevel) userInfo:nil repeats:NO];
	}
	
	if([playmusic checksound]){
		[playmusic changevolume:[playmusic getvolume:0]];
		[playmusic playmusic];
	}
	pview.level = level;
	pview.checkbutton.hidden = NO;
	pview.tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv%d_cut_%d_tip.png",level, pview.cut]];
	NSString *tmp1;
	tmp1 = [NSString stringWithFormat:@"lv%d_duma_bg.png",level];
	NSString *tmp2;
	tmp2 = [NSString stringWithFormat:@"lv%d_head_part.bmp",level];
	//tmp2 = [NSString stringWithFormat:@"lv%d_cut%d_part.bmp",level,cut];
	[self loadImage:tmp1 Hair:tmp2];
	

	
	[Animation setAnimationImage:pview.bubble :@"bubble_00" :@"png" :1 :6];
	[Animation setAndplay:pview.bubble :0.6 :0];
	pview.readline = 1;
	switch (level) {
		case 1: {
			switch (cut) {
				case 1:
					pview.end_redline = YES;						
					break;
				case 2:
					pview.end_redline = YES;
					break;
				case 3:
					pview.end_redline = YES;
					break;
				default:
					break;
			}	
			break;
		}	
		default:
			break;
	}
	if(pview.end_redline == YES) {
		pview.Redline.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv%d_cut%d_redline_1.png",level,cut]];
		//pview.Tap.image = [UIImage imageNamed:@"tap_01.png"];
		[pview.Tap startAnimating];
	}
	else						   
		pview.ShowRedLine = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self.pview selector:@selector(ShowRedLine:) userInfo:nil repeats:YES];
}

-(void) loadImage:(NSString *)Bgfilepath Hair:(NSString *)Hairfilepath {
	bgimage = [UIImage imageNamed:Bgfilepath];
	pview.bgphoto.image = bgimage;
	syimage = [UIImage imageNamed:Hairfilepath];
	pview.inImage = CGImageCreateCopy(syimage.CGImage);
	pview.Hair.image = syimage;	
}	

-(BOOL) Compare:(CGImageRef)inImage1 TwoImage:(NSString *)CutfinImage{
	BOOL PASS;
	CGImageRef inImage2;
	compareimage = [UIImage imageNamed:CutfinImage];
	inImage2 = CGImageCreateCopy(compareimage.CGImage);
	
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx1 = [self createARGBBitmapContextFromImage:inImage1];
	CGContextRef cgctx2 = [self createARGBBitmapContextFromImage:inImage2];
	//if (cgctx1 == NULL) { return false; /* error */ }
	//if (cgctx2 == NULL) { return false; /* error */ }
	
    size_t w1 = CGImageGetWidth(inImage1);
	size_t h1 = CGImageGetHeight(inImage1);
	CGRect rect1 = {{0,0},{w1,h1}}; 
	
	size_t w2 = CGImageGetWidth(inImage2);
	size_t h2 = CGImageGetHeight(inImage2);
	CGRect rect2 = {{0,0},{w2,h2}}; 
	
	// Draw the image to the bitmap context. Once we draw, the memory
	// allocated for the context for rendering will then contain the
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx1, rect1, inImage1); 
	CGContextDrawImage(cgctx2, rect2, inImage2);
	
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	unsigned char* data1 = CGBitmapContextGetData (cgctx1);
	unsigned char* data2 = CGBitmapContextGetData (cgctx2);
	
	if (data1 != NULL && data2 != NULL) {
		int differ_point = 0;
		//offset locates the pixel in the data from x,y.
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		for (int i = 0; i < 320; i++) {
			for(int j = 0; j < 266; j++) {
				int offset1 = 4 * (w1 * j + i);
				int offset2 = 4 * (w2 * j + i);
				int alpha1 =  data1[offset1];
		//		int alpha2 =  data2[offset2];
				int red1 = data1[offset1+1];
				int green1 = data1[offset1+2];					
				int blue1 = data1[offset1+3];
				int red2 = data2[offset2+1];
				int green2 = data2[offset2+2];
				int blue2 = data2[offset2+3];
				
				if(alpha1 == 255) {

					if((red1 != red2) || (green1 != green2) || (blue1 != blue2))
						differ_point++;
					
					//boundary += fabsf(red1 - red2) + fabsf(green1 - green2) + fabsf(blue1 - blue2);					
				} 
				if(red2 == 76 && green2 == 73 && blue2 ==72 ) {
					if(alpha1 != 255) 
						differ_point++;
				}	
			}	
		}
		switch (level) {
			case 1:{
				if(differ_point < Level1_Check) {
					PASS = true;
				}	
				else {
					PASS = false;
				}
				break;
			}	
			case 2: {
				if(differ_point < Level2_Check) {
					PASS = true;
				}	
				else {
					PASS = false;
				}
				break;
			}	
			default:
				break;
		}
		
		NSLog(@"differ_point ================ %d",differ_point);
		//NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
		//color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
	}
		
	if(inImage2 != NULL){
		CGImageRelease(inImage2);
		compareimage = nil;
	}
		
	// When finished, release the context
	CGContextRelease(cgctx1);
	CGContextRelease(cgctx2);
	
	// Free image data memory for the context
	if (data1) { free(data1); }
	if (data2) { free(data2); }	
	NSLog(@"////////////////////////////////////");
	return PASS;	
}	

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
	
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
	size_t pixelsWide = CGImageGetWidth(inImage);
	size_t pixelsHigh = CGImageGetHeight(inImage);
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow   = (pixelsWide * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();
	if (colorSpace == NULL)
	{
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL)
	{
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits
	// per component. Regardless of what the source image format is
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	
	return context;
}


- (void) JudgeWinLose:(NSTimer *) timer {
	
	NSString *filepath = ((NSString*) timer.userInfo);	
	count ++;
	if(count == 3) {
		if([filepath isEqualToString:@"check_pass.png"]) {
			if(cut == 1) {				
				if(level == 3) 
					Score_Show = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Score_Show:) userInfo:filepath repeats:YES];
				else {
					[self nextlevel];
					Pausebutton.hidden = NO;
				}
			}	
			else {
				Pausebutton.hidden = NO;
				[self nextcut];
			}
		}	
		else if([filepath isEqualToString:@"check_timeout.png"]) {
			Score_Show = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Score_Show:) userInfo:filepath repeats:YES];
		}	
		else if([filepath isEqualToString:@"check_fail.png"]){
			Pausebutton.hidden = NO;
			[self undo];
		}	
		count = 0;
		[timer invalidate];
	}		
	else {		
		NSMutableArray *array = [[NSMutableArray alloc] init];		
		[array addObject:[UIImage imageNamed:filepath]];
		[array addObject:[UIImage imageNamed:@"Nil.png"]];
		Win_Lose.animationImages = array;
		Win_Lose.animationDuration = 0.5;
		Win_Lose.animationRepeatCount = 1;
		[array release];
		[Win_Lose startAnimating];	
		if([filepath isEqualToString:@"check_pass.png"]) {
			if([rightmusic checksound]){
				[rightmusic changevolume:[rightmusic getvolume:0]];
				[rightmusic playmusic];
			}
		}
		else if([filepath isEqualToString:@"check_fail.png"]) {
			if([wrongmusic checksound]){
				[wrongmusic changevolume:[wrongmusic getvolume:0]];
				[wrongmusic playmusic];
			}
		}
		else if([filepath isEqualToString:@"check_timeout.png"]) {
			if([wrongmusic checksound]){
				[wrongmusic changevolume:[wrongmusic getvolume:0]];
				[wrongmusic playmusic];
			}		
		}	
	}
	printf("leepaaaaaaaaaaassssssssssssssssssssssssssssssssssssss\n");
	//Score_Show = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Score_Show:) userInfo:filepath repeats:NO];	
}	

- (void) Score_Show:(NSTimer *) timer {
	printf("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n");
	Score_Back.hidden = NO;
	Menu.hidden = NO;
	Score_Continue.hidden = NO;
	printf("dddddddddddddddddddddddddddddddddddd\n");

	pic_path = [NSString stringWithString:(NSString*) timer.userInfo];
//	NSLog(pic_path);
	printf("ccccccccccccccccccccccccccccccccc");
		printf("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		Win_Lose.image = [UIImage imageNamed:@"score_word.png"];		
		[Animation setAnimationImage:Frame :@"score_bg_line_" :@"png" :1 :2];
		[Animation setAndplay:Frame :0.5 :0];
		NSString *filepath = [self scorefilepath];
		if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
			NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
			score = [[array objectAtIndex:0]intValue];					
			[array release];
		}
		printf("================score  %d=======================\n",score);
		N0.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 1000000000]];
		score %= 1000000000;
		N1.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 100000000]];
		score %= 100000000;
		N2.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 10000000]];
		score %= 10000000;
		N3.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 1000000]];
		score %= 1000000;
		N4.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 100000]];
		score %= 100000;
		N5.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 10000]];
		score %= 10000;
		N6.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 1000]];
		score %= 1000;
		N7.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 100]];
		score %= 100;
		N8.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score / 10]];
		score %= 10;
		N9.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%d.png",score ]];
	//}

}	
- (void) Time_Count:(NSTimer *) timer {
	
	time_count--;
	if(time_count == -1){ 		
		[timer invalidate];
		Time_Count = nil;
		//Time.image = nil;
		ShowWinLose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(JudgeWinLose:) userInfo:@"check_timeout.png" repeats:YES];
	}
	else {
		/*if (level == 1) {
			NSString *tmp;
			tmp = [NSString stringWithFormat:@"level_time_000%d.png",time_count];	
			Time.image = [UIImage imageNamed:tmp];				
		}
		else if(level == 2) {
			NSString *tmp;
			tmp = [NSString stringWithFormat:@"level_time_000%d.png",time_count];	
			Time.image = [UIImage imageNamed:tmp];						
		}*/
		int seconds;
		seconds = time_count % 60;
		T0.image = [UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",time_count / 60]];
		T1.image = [UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",seconds / 10]];
		T2.image = [UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",seconds % 10]];
	}				
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

    level = level;
	pview.level = level;
	cut = 1;
	pview.cut = 1;
	showstart = YES;
	NSLog(@"playview %d %d",level,cut);
	[super viewDidLoad];
	[Animation setAnimationImage:Frame :@"pause_line_" :@"png" :1 :2];
	/*[Animation setAnimationImage:Mouse :@"time_mouse_00" :@"png" :1 :23];	
	[Animation setAnimationImage:Emotion :@"emo_lv1_00" :@"png" :1 :3];	
	[Animation setAnimationImage:pview.scissor :@"level_scissor_00" :@"png" :1 :2];*/
	Back.hidden = YES;
	Continuebutton.hidden = YES;
	Score_Back.hidden = YES;
	Menu.hidden = YES;
	Score_Continue.hidden = YES;
	pview.end_redline = NO;
	//[Animation setAnimationImage:Mouse :@"time_mouse_00" :@"png" :1 :23];
	playmusic = [[PMusic alloc] initWithFileName:@"PlayMusic"];
	[playmusic setinfinloop];
	pview.cutmusic = [[PMusic alloc] initWithFileName:@"cut"];
	rightmusic = [[PMusic alloc] initWithFileName:@"right"];
	wrongmusic = [[PMusic alloc] initWithFileName:@"wrong"];
	
	NSMutableArray *array = [[NSMutableArray alloc] init];		
	[array addObject:[UIImage imageNamed:@"tap_01.png"]];
	[array addObject:[UIImage imageNamed:@"Nil.png"]];
	pview.Tap.animationImages = array;
	pview.Tap.animationDuration = 1.0;
	pview.Tap.animationRepeatCount = -1;
	[array release];
	[self reload];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
- (void)dealloc {
	[playmusic stopmusic];
	[playmusic release];
	[pview release];
	[bgimage release];
	[syimage release];
	[compareimage release];
	[imageView release];
	[Win_Lose release];
	[ShowWinLose release];
	[Time release];
	[Mouse release];
	[Time_Count release];
	[Emotion release];	
	[Frame release];
	[Tap release];
	//[Frame2 release];	
	[Continuebutton release];
	[Back release];
	[Score_Back release];
	[Pausebutton release];
	[Menu release];
	[Score_Continue release];
	[Score_Show release];
	[N0 release];
	[N1 release];
	[N2 release];
	[N3 release];
	[N4 release];
	[N5 release];
	[N6 release];
	[N7 release];
	[N8 release];
	[N9 release];
	[T0 release];
	[T1 release];
	[T2 release];
    [super dealloc];
}

- (void) nextcut {
	[self reset];	
	[self reload];		
}	

- (void) nextlevel {
	cut = 1;
	pview.cut = 1;
	showstart = YES;
	[self reset];
	[self reload];
}	

- (void) reset {
	Score_Back.hidden = YES;
	Menu.hidden = YES;
	Score_Continue.hidden = YES;
	CGImageRelease(pview.inImage);
	pview.picImageview.image = nil;
	pview.drawImage.image = nil;
	pview.end_redline = NO;
	if (pview.ShowRedLine != nil) {
		[pview.ShowRedLine invalidate];	
		pview.ShowRedLine = nil;
	}
	pview.Redline.image = nil;
	//pview.Tap.image = nil;
	[pview.Tap stopAnimating];
}	

-(NSString *) datafilepath{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:levelfile];
}


-(NSString *) scorefilepath{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:scorefile];
}

-(void) countscore:(int) add{
	NSString *filepath = [self scorefilepath];
	if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
		score = [[array objectAtIndex:0]intValue];					
		[array release];
	}
	printf("eeeeeeeeeeeeeeeeeeeee score %d fwefewefwefweffewfwe",score);
	score += add;
	NSNumber *s = [NSNumber numberWithInt:score];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:s];
	[array writeToFile:filepath atomically:YES];
	[array release];	
}	
-(IBAction) check{
	
	[self playclick];
	pview.checkbutton.hidden = YES;
	count = 0;
	count1 = 0;
	NSString *tmp;
	Pausebutton.hidden = YES;
	tmp = [NSString stringWithFormat:@"lv%d_cut%d_part.bmp",level,cut];	
//	NSLog(tmp);
	switch(level) {
		case 1: {
			BOOL pass;
			pass = [self Compare:pview.inImage TwoImage:tmp];
			if(pass == true) {
				[self countscore:10]; 
				NSLog(@"sssssssssssssssssssssucess");
				if(cut == 4) {					
					[self countscore:500]; 
					level++;
					pview.level++;
					pview.readline = 0;
					cut=1;
					pview.cut = 1;
					if (Time_Count != nil) {
						[Time_Count invalidate];
						Time_Count = nil;
						//Time.image = nil;
						//Mouse.image = nil;
					}	
					/*BOOL level_skip;
					NSString *filepath1 = [self datafilepath];
					if([[NSFileManager defaultManager] fileExistsAtPath:filepath1]){
						NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath1];
						level_skip = [[array objectAtIndex:2]boolValue];					
						[array release];
						NSLog(@"33333333333333333333333333333333333333333");
					}
					NSLog(@"33333333333333333333333333333333333333333");
					
					if(!level_skip) {
						NSLog(@"31233333333333333333333");
					int i=0;
					NSString *filepath = [self datafilepath];
					NSMutableArray *array = [[NSMutableArray alloc] init];
					NSNumber *lv = [NSNumber numberWithInt:1];
					[array addObject:lv];
					for (i=0; i<2; i++) {
						NSNumber *tmp = [NSNumber numberWithBool:YES];
						[array addObject:tmp];
						[tmp release];
					}
					for (i; i<6; i++) {
						NSNumber *tmp = [NSNumber numberWithBool:NO];
						[array addObject:tmp];
						[tmp release];
					}
					[array writeToFile:filepath atomically:YES];
					[array release];
					 
					}*/	
				}	
				else {
					cut++;
					pview.cut++;
					pview.readline = 0;
					//[self nextcut];
				}	
				
				ShowWinLose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(JudgeWinLose:) userInfo:@"check_pass.png" repeats:YES];
				
			}	
			else {
				/*if (Time_Count != nil) {
					[Time_Count invalidate];
					Time_Count = nil;
					Time.image = nil;
					Mouse.image = nil;
				}	*/
				NSLog(@"ffffffffffffffffffffffffail");
				ShowWinLose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(JudgeWinLose:) userInfo:@"check_fail.png" repeats:YES];

			}
			break;
		}	
		case 2:	{
			BOOL pass;
			pass = [self Compare:pview.inImage TwoImage:tmp];
			if(pass == true) {
				[self countscore:10];
				
				//[self ShowWinLose:@"check_pass.png"];
				if(cut == 3) {
					[self countscore:800]; 
					level++;
					pview.level++;
					pview.readline = 0;
					cut=1;
					pview.cut = 1;
					if (Time_Count != nil) {
						[Time_Count invalidate];
						Time_Count = nil;
						//Time.image = nil;
						//Mouse.image = nil;
					}	
					/*BOOL level_skip;
					NSString *filepath1 = [self datafilepath];
					if([[NSFileManager defaultManager] fileExistsAtPath:filepath1]){
						NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath1];
						level_skip = [[array objectAtIndex:3]boolValue];					
						[array release];
					}
					if(level_skip == FALSE) {
					int i=0;
					NSString *filepath = [self datafilepath];
					NSMutableArray *array = [[NSMutableArray alloc] init];
					NSNumber *lv = [NSNumber numberWithInt:1];
					[array addObject:lv];
					for (i=0; i<3; i++) {
						NSNumber *tmp = [NSNumber numberWithBool:YES];
						[array addObject:tmp];
						[tmp release];
					}
					for (i; i<5; i++) {
						NSNumber *tmp = [NSNumber numberWithBool:NO];
						[array addObject:tmp];
						[tmp release];
					}
					[array writeToFile:filepath atomically:YES];
					[array release];*/
					//[self nextlevel];
					//}	
				}	
				else {
					cut++;
					pview.cut++;
					pview.readline = 0;
					NSLog(@"it pass showsucess");
					//[self nextcut];
				}	
				ShowWinLose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(JudgeWinLose:) userInfo:@"check_pass.png" repeats:YES];
			}
			else {
				/*if (Time_Count != nil) {
					[Time_Count invalidate];
					Time_Count = nil;
					Time.image = nil;
					Mouse.image = nil;
				}	*/
				ShowWinLose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(JudgeWinLose:) userInfo:@"check_fail.png" repeats:YES];
				NSLog(@"it pass showfail");
			}
			break;
		}	
		case 3: {
			
			break;
		}	
		default:
			break;
	}		
}	

- (IBAction) Pause {
	[self playclick];
	Continuebutton.hidden = NO;
	Back.hidden = NO;
	//[Mouse stopAnimating];
	[Emotion stopAnimating];
	Win_Lose.image = [UIImage imageNamed:@"pause_bg.png"];
	[Animation setAndplay:Frame :0.2 :0];
	if ([Time_Count isValid ] && Time_Count!=nil) {
		[Time_Count invalidate];
		Time_Count = nil;
	}
}	

- (IBAction) Resume {
	[self playclick];
	[self loadTimer];
	/*
	if (level == 1) {
		Emotion_Change = [NSTimer scheduledTimerWithTimeInterval:6.25 target:self selector:@selector(Emotion_Change:) userInfo:nil repeats:YES];
		Time_Count = [NSTimer scheduledTimerWithTimeInterval:6.25 target:self selector:@selector(Time_Count:) userInfo:nil repeats:YES];	
	}
	else if(level == 2)	{ 
		Emotion_Change = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(Emotion_Change:) userInfo:nil repeats:YES];
		Time_Count = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(Time_Count:) userInfo:nil repeats:YES];				
	}*/
	//[Mouse startAnimating];
	[Frame stopAnimating];
	Back.hidden = YES;
	Continuebutton.hidden=YES;
	Win_Lose.image = nil;
}	

- (IBAction) undo {
	[self playclick];
	[self reset];
	[self reload];
}

- (IBAction) back {
	NSArray *array = self.navigationController.viewControllers;
	ChooseLevel *tmp = [array objectAtIndex:[array count]-2];
	[tmp reloadlevel];
	[tmp.frame startAnimating];
	[self playclick];
	showstart =YES;
	Frame.image = nil;
	Back.hidden = YES;
	Continuebutton.hidden = YES;
	[Frame stopAnimating];
	[playmusic stopmusic];
	
	//printf("%d",(syimage.retainCount));
	pview.readline = 1;
	cut=1;
	pview.cut = 1;
	[self reset];
	[super back];
}

- (IBAction) Continue {
	if (Score_Show != nil) {
		[Score_Show invalidate];
		Score_Show = nil;
	} 
	Win_Lose.image = nil;
	N0.image = nil;
	N1.image = nil;
	N2.image = nil;
	N3.image = nil;
	N4.image = nil;
	N5.image = nil;
	N6.image = nil;
	N7.image = nil;
	N8.image = nil;
	N9.image = nil;
	[Frame stopAnimating];	
	[Animation setAnimationImage:Frame :@"pause_line_" :@"png" :1 :2];
	if([pic_path isEqualToString:@"check_pass.png"]) {
		if(cut == 1) {				
			if(level == 3) 
				[self back];
			else {
				[self nextlevel];
			}	
		}	
		else {
			[self nextcut];
		}
	}	
	else if([pic_path isEqualToString:@"check_fail.png"]) {
		[self undo];
		//[self back];
	}	
	else if([pic_path isEqualToString:@"check_timeout.png"]) {
		[self back];
	}
	pic_path = nil;	
	Pausebutton.hidden = NO;
}	
@end
