//
//  Waveplay.m
//  Meme
//
//  Created by LEE on 2010/4/20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Waveplay.h"
#import "ChooseLevel.h"

@implementation Waveplay
@synthesize bgphoto;
@synthesize HairView;
@synthesize BlueLineView;
@synthesize PicImageView;
@synthesize hair;
@synthesize picimage;
@synthesize compareimage;
@synthesize inImage;
@synthesize firsttouch;
@synthesize lasttouch;
@synthesize ShowBlueLine;
@synthesize Win_Lose;
@synthesize Frame;
//@synthesize Frame2;
@synthesize Continuebutton;
@synthesize Back;
@synthesize Pausebutton;
@synthesize Emotion;
@synthesize Time;
@synthesize Mouse;
@synthesize ShowWinLose;
@synthesize level;
@synthesize cut;
@synthesize count;
@synthesize time_count;
@synthesize score;
@synthesize Time_Count;
@synthesize Score_Frame;
@synthesize Tap;
@synthesize checkbutton;
@synthesize bubble;
@synthesize tip;

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
@synthesize Score_Continue;
@synthesize Score_Back;
@synthesize Menu;
@synthesize Score_Show;

- (void) loadTimer {	
	[Animation setAndplay:Emotion :5 :0];	
	//[Animation setAndplay:Mouse :120 :1];
	//time_count ++;
	//if(time_count == 120) {
		Time_Count = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Time_Count:) userInfo:nil repeats:YES];			
}
- (void) ShowLevel {
	[Frame stopAnimating];
	Win_Lose.image = nil;
	showstart = NO;
	if(cut == 1) {
		time_count = 150;
		[Animation setAnimationImage:Emotion :@"emo_lv3_00" :@"png" :1 :3];	
		//Mouse.image = [UIImage imageNamed:@"lv_3_mse_001.png"];
		T0.image = [UIImage imageNamed:@"time_nb_2.png"];
		T1.image = [UIImage imageNamed:@"time_nb_3.png"];
		T2.image = [UIImage imageNamed:@"time_nb_0.png"];
		[self loadTimer];
	}	
}

-(void) reload {
	backbutton.hidden=YES;
	Continuebutton.hidden=YES;
	if(showstart){

		
		//Win_Lose.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv%d_1_start.png",level]];
		Win_Lose.image = [UIImage imageNamed:@"lv3_start_page.png"];
		[Animation setAnimationImage:Frame :@"lv3_start_page_line_" :@"png" :1 :2];
		[Animation setAndplay:Frame :0.5 :4];
		[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(ShowLevel) userInfo:nil repeats:NO];
	}
	
	if([playmusic checksound]){
		[playmusic changevolume:[playmusic getvolume:0]];
		[playmusic playmusic];
	}
	
	checkbutton.hidden = NO;
	tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv%d_%d_tip.png",level, cut]];
	
	bgphoto.image = [UIImage imageNamed:@"lv3_bg.png"];
	HairView.image = [UIImage imageNamed:@"lv3_normal.bmp"];
	//BlueLineView.image = [UIImage imageNamed:@"lv3_line.png"];
	inImage = CGImageCreateCopy(HairView.image.CGImage);
	if(picimage == nil) {
		self.picimage = [UIImage imageNamed:@"lv3_hair.png"];
		PicImageView.frame = self.view.frame;
		[self.view addSubview:PicImageView];	
	}
	[self.view addSubview:Win_Lose];
	[self.view addSubview:Frame];
	if(ShowBlueLine != nil) {
		[ShowBlueLine invalidate];
		ShowBlueLine = nil;
	}
	[Animation setAnimationImage:bubble :@"bubble_00" :@"png" :1 :6];
	[Animation setAndplay:bubble :0.6 :0];
	[Tap startAnimating];
	
	ShowBlueLine = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(ShowBlueLine:) userInfo:nil repeats:YES];
}	

-(void) loadImage:(NSString *)Bgfilepath Hair:(NSString *)Hairfilepath {
	
	bgphoto.image = [UIImage imageNamed:@"lv3_bg.png"];
	HairView.image = [UIImage imageNamed:@"lv3_unfinish.bmp"];
	inImage = CGImageCreateCopy(HairView.image.CGImage);
	BlueLineView.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv3_%d_line.png",cut]];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	firsttouch = [touch locationInView:self.view];
	lasttouch = [touch locationInView:self.view];
	if(!showstart) {
		if(lasttouch.y <= 419 && lasttouch.y >= 154) 
			[self draw];
	}	
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	lasttouch = [touch locationInView:self.view];
	if(!showstart) {
		if(lasttouch.y <= 419 && lasttouch.y >= 154)
			[self draw];
	}	
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	lasttouch = [touch locationInView:self.view];
	if(!showstart) {
		if(lasttouch.y <= 419 && lasttouch.y >= 154) {
			[self draw];
			[self PixelColorAtLocation:lasttouch];
		}
	}	
}

-(void) draw {
	UIGraphicsBeginImageContext(self.view.frame.size);
	[PicImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[picimage drawAtPoint:CGPointMake(lasttouch.x-picimage.size.width/2, lasttouch.y-picimage.size.height/2)];
	PicImageView.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();		
}	
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


- (void) PixelColorAtLocation:(CGPoint)point {
	
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
	if (cgctx == NULL) { return ; /* error */ }
	
    size_t w = CGImageGetWidth(inImage);
	size_t h = CGImageGetHeight(inImage);
	CGRect rect = {{0,0},{w,h}}; 
	
	// Draw the image to the bitmap context. Once we draw, the memory 
	// allocated for the context for rendering will then contain the 
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage);
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	unsigned char* data = CGBitmapContextGetData (cgctx);
	
	if (data != NULL) {
		//offset locates the pixel in the data from x,y. 
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		
		int offset = 4 * ((w * (point.y - self.HairView.frame.origin.y)) + (point.x - self.HairView.frame.origin.x));
		//int offset = 4 * ((w * round(point.y)) + round(point.x));
		
		data[offset] = 0.0f;
		for(int i = -10; i < 10; i++) {
			for(int j = -10; j < 10; j++) {
				int xx = (point.x + j - self.HairView.frame.origin.x);
				int yy = (point.y + i - self.HairView.frame.origin.y);
				if( xx <= 320 && xx >= 0 && yy <= 265 && yy >= 0) {
					int off = 4 * ((w * yy) + xx);
					data[off] = 0.0f;
				}	
			}		
		}
	}
	// When finished, release the context
	if(inImage != NULL){
		CGImageRelease(inImage);
	}
	inImage =  CGBitmapContextCreateImage(cgctx);
	HairView.image = nil;
	HairView.image = [UIImage imageWithCGImage:inImage];
	CGContextRelease(cgctx);
	// Free image data memory for the context
	if (data) { 		
		free(data);
	}	
	
}	

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) BitMapImage {
	
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
	size_t pixelsWide = CGImageGetWidth(BitMapImage);
	size_t pixelsHigh = CGImageGetHeight(BitMapImage);
	
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

- (BOOL) Compare:(CGImageRef)inImage1 TwoImage:(NSString *) CurlinImage {
	
	CGImageRef inImage2;
	compareimage = [UIImage imageNamed:CurlinImage];
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
	int differ_point = 0;
	if (data1 != NULL && data2 != NULL) {
		
		//offset locates the pixel in the data from x,y.
		//4 for 4 bytes of data per pixel, w is width of one row of data.
	
		for (int i = 0; i < 320; i++) {
			for(int j = 0; j < 265; j++) {
				int offset1 = 4 * (w1 * j + i);
				int offset2 = 4 * (w2 * j + i);
				int alpha1 =  data1[offset1];
				//		int alpha2 =  data2[offset2];
//				int red1 = data1[offset1+1];
//				int green1 = data1[offset1+2];					
//				int blue1 = data1[offset1+3];
				int red2 = data2[offset2+1];
				int green2 = data2[offset2+2];
				int blue2 = data2[offset2+3];
				if(alpha1 == 0) {
					if(red2 != 76 || green2 != 73 || blue2 != 72) 
						differ_point++;
				}	
				if(red2 == 76 && green2 == 73 && blue2 ==72) {
					if(alpha1 != 0)
						differ_point++;
				}	
			}
		}
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
	NSLog(@"differ_point ================ %d",differ_point);
	if(differ_point < Level3_Check) 
		return true;
	else 
		return false;
}


- (void) JudgeWinLose:(NSTimer *) timer {
	
	NSString *filepath = ((NSString*) timer.userInfo);	
	count ++;
	if(count == 3) {
		//[self reset];
		//[self reload];
		//Score_Show = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Score_Show:) userInfo:filepath repeats:YES];
		if([filepath isEqualToString:@"check_pass.png"]) {
			if(cut == 1) {
				/*if(level == 3) 
					[self back];
				else {
					[self nextlevel];
				}*/
				Score_Show = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Score_Show:) userInfo:filepath repeats:YES];
			}	
			else {
				[self nextcut];
				Pausebutton.hidden = NO;
			}
		}
		else if([filepath isEqualToString:@"check_fail.png"]) {
			[self undo];
			Pausebutton.hidden = NO;
		}	
		else if([filepath isEqualToString:@"lv3_time_up.png"]) {
			Score_Show = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Score_Show:) userInfo:filepath repeats:YES];
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
}	

- (void) Score_Show:(NSTimer *) timer {
	
	/*if (Time_Count != nil) {
		[Time_Count invalidate];
		Time_Count = nil;
		Time.image = nil;
		Mouse.image = nil;
	}	*/
	
	Score_Back.hidden = NO;
	Menu.hidden = NO;
	Score_Continue.hidden = NO;
	//CGImageRelease(inImage);
	PicImageView.image = nil;
	pic_path = [NSString stringWithString:(NSString*) timer.userInfo];	
	
	Score_Frame.image = [UIImage imageNamed:@"score_word.png"];		
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

- (void) ShowBlueLine:(NSTimer*) timer {
	
		
	/*NSString *filepath;
	filepath = [NSString stringWithFormat:@"lv%d_cut%d_redline_%d.png",level,cut,readline];	
	UIImage *tmp = [UIImage imageNamed:filepath];*/
	UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"lv3_%d_line.png",cut]];
	if(image != nil && [timer isValid]) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[array addObject:image];
		[array addObject:[UIImage imageNamed:@"Nil.png"]];
		BlueLineView.animationImages = array;
		BlueLineView.animationDuration = 0.4;
		BlueLineView.animationRepeatCount = 1;
		[array release];
		[BlueLineView startAnimating];
	}	
	//	NSLog(@"Timer stoppppppppppppppppppppppppppppppppppppp");
}	


- (void) Time_Count:(NSTimer *) timer {


	time_count --;
	if(time_count == -1) {		
		[timer invalidate];
		Time_Count = nil;
		//Mouse.image = nil;	
		ShowWinLose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(JudgeWinLose:) userInfo:@"lv3_time_up.png" repeats:YES];
	}
	else {
		int seconds;
		seconds = time_count % 60;
		T0.image = [UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",time_count / 60]];
		T1.image = [UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",seconds / 10]];
		T2.image = [UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",seconds % 10]];
		/*NSString *tmp;
		tmp = [NSString stringWithFormat:@"lv_3_mse_00%d.png",time_count];	
		Mouse.image = [UIImage imageNamed:tmp];*/
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	level = 3;
	cut = 1;
	showstart = YES;
    [super viewDidLoad];
	[Animation setAnimationImage:Frame :@"pause_line_" :@"png" :1 :2];
	Back.hidden = YES;
	Continuebutton.hidden =YES;
	Score_Back.hidden = YES;
	Menu.hidden = YES;
	Score_Continue.hidden = YES;
	NSLog(@"mkdemewkdweewewwe");
	//[Animation setAnimationImage:Mouse :@"lv_3_mse_00" :@"png" :1 :29];
	NSLog(@"JEIROFJEIRJFERJFEIOEFJOEIJR");
	playmusic = [[PMusic alloc] initWithFileName:@"PlayMusic"];
	[playmusic setinfinloop];
	PicImageView = [[UIImageView alloc] initWithImage:nil];
	Win_Lose = [[UIImageView alloc] initWithImage:nil];
	Win_Lose.frame = self.view.frame;
	Frame = [[UIImageView alloc] initWithImage:nil];
	Frame.frame = self.view.frame;
	
	rightmusic = [[PMusic alloc] initWithFileName:@"right"];
	wrongmusic = [[PMusic alloc] initWithFileName:@"wrong"];
	
	NSMutableArray *array = [[NSMutableArray alloc] init];		
	[array addObject:[UIImage imageNamed:@"tap_01.png"]];
	[array addObject:[UIImage imageNamed:@"Nil.png"]];
	Tap.animationImages = array;
	Tap.animationDuration = 1.0;
	Tap.animationRepeatCount = -1;
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [bgphoto release];
	[HairView release];
	[BlueLineView release];
	[PicImageView release];
	[hair release];
	[picimage release];
	[compareimage release];
	[ShowBlueLine release];
	[Win_Lose release];
	[ShowWinLose release];
	[Time release];
	[Mouse release];
	[Emotion release];	
	[Frame release];
	//[Frame2 release];
	[Continuebutton release];
	[Back release];
	[Score_Back release];
	[Menu release];
	[Pausebutton release];
	[Score_Continue release];
	[Score_Show release];
	[Score_Frame release];
	[Tap release];
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
	
	score += add;
	NSNumber *s = [NSNumber numberWithInt:score];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:s];
	[array writeToFile:filepath atomically:YES];
	[array release];	
}	

- (IBAction) check {
	[self playclick];
	checkbutton.hidden = YES;
	Pausebutton.hidden = YES;
	NSString *tmp;
	tmp = [NSString stringWithFormat:@"lv3_%d_check.bmp",cut];	
	BOOL pass;
	pass = [self Compare:inImage TwoImage:tmp];
	if(pass == true) {
		[self countscore:10];
		if(cut == 4) {
			NSLog(@"pass33333333333333333333333333333333333");
			[self countscore:1200];
			//level++;
			cut = 1;
			if (Time_Count != nil) {
				[Time_Count invalidate];
				Time_Count = nil;
				//Time.image = nil;
				//Mouse.image = nil;
			}			
			/*int i=0;
			NSString *filepath = [self datafilepath];
			NSMutableArray *array = [[NSMutableArray alloc] init];
			NSNumber *lv = [NSNumber numberWithInt:1];
			[array addObject:lv];
			for (i=0; i<4; i++) {
				NSNumber *tmp = [NSNumber numberWithBool:YES];
				[array addObject:tmp];
				[tmp release];
			}
			for (i; i<4; i++) {
				NSNumber *tmp = [NSNumber numberWithBool:NO];
				[array addObject:tmp];
				[tmp release];
			}
			[array writeToFile:filepath atomically:YES];
			[array release];*/		
		}	
		else {
			cut++;
		}
		ShowWinLose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(JudgeWinLose:) userInfo:@"check_pass.png" repeats:YES];
	}	
	else {
		/*if (Time_Count != nil) {
			[Time_Count invalidate];
			Time_Count = nil;
			Time.image = nil;
			Mouse.image = nil;
		}*/
		ShowWinLose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(JudgeWinLose:) userInfo:@"check_fail.png" repeats:YES];
	}

}
- (IBAction) Pause {
	[self playclick];
	Continuebutton.hidden = NO;
	Back.hidden = NO;
	backbutton.hidden=NO;
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
	//[Mouse startAnimating];
	[Emotion startAnimating];
	[Frame stopAnimating];
	Back.hidden = YES;
	backbutton.hidden=YES;
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
	cut=1;
	[self reset];
	[super back];	
}

- (void) reset {
	Score_Back.hidden = YES;
	Menu.hidden = YES;
	Score_Continue.hidden = YES;
	CGImageRelease(inImage);
	PicImageView.image = nil;
	if (ShowBlueLine != nil) {
		[ShowBlueLine invalidate];	
		ShowBlueLine = nil;
	}
	[Tap stopAnimating];
}	

- (void) nextcut {
	[self reset];	
	[self reload];		
}	

- (void) nextlevel {
	cut = 1;
	showstart = YES;
	[self reset];
	[self reload];
}	

- (IBAction) menu {
	
}	

- (IBAction) Continue {
	checkbutton.hidden=NO;
	if (Score_Show != nil) {
		[Score_Show invalidate];
		Score_Show = nil;
	} 
	[Animation setAnimationImage:Frame :@"pause_line_" :@"png" :1 :2];
	Score_Frame.image = nil;	
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
	if([pic_path isEqualToString:@"check_pass.png"]) {
		NSLog(@"final  hththfhgfhghfgh  %d   %d",cut,level);
		
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
	}	
	else if([pic_path isEqualToString:@"lv3_time_up.png"]) {
		[self back];
	}	
	pic_path = nil;	
	Pausebutton.hidden = NO;
	//if(cut < 4)
	//[self loadTimer];
}	

@end
