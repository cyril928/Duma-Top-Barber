//
//  View.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/17.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "View.h"
#import "Type.h"
#import "PlayView.h"

@implementation View
@synthesize drawImage;
@synthesize bgphoto;
@synthesize shapetype;
@synthesize picImage;
@synthesize picImageview;
@synthesize Body;
@synthesize Hair;
@synthesize Redline;
@synthesize Tap;
@synthesize inImage;
@synthesize firsttouch;
@synthesize lasttouch;
@synthesize currenttouch;
@synthesize BeginPoint;
@synthesize EndPoint;
@synthesize ShowRedLine;
@synthesize level;
@synthesize cut;
@synthesize readline;
@synthesize count;

@synthesize checkbutton;
@synthesize bubble;
@synthesize tip;
@synthesize scissor;
@synthesize Scissor_Move;

@synthesize end_redline;
@synthesize cutmusic;
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}
- (id)initWithCoder:(NSCoder*)coder
{
    if ( ( self = [super initWithCoder:coder] ) ) {
        if (picImage == nil){
            self.picImage = [UIImage imageNamed:@"pika.png"];
			drawImage = [[UIImageView alloc] initWithImage:nil];
			picImageview = [[UIImageView alloc] initWithImage:nil];
			picImageview.frame = self.frame;
			[self addSubview:picImageview];
		}
	}
	step = 0;
	currenttouch = CGPointMake(160, 240);
    return self;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	firsttouch = [touch locationInView:self];
	lasttouch = [touch locationInView:self];
	//[self draw];
	step = 0;
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	lasttouch = [touch locationInView:self];
	//[self draw];
	NowColor = nil;
	FrontColor = nil;
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	lasttouch = [touch locationInView:self];
	//[self draw];
	if(lasttouch.y < self.Hair.frame.origin.y + self.Hair.frame.size.height ) {
	
		NowColor = [self PixelColorAtLocation:lasttouch]; 
		FrontColor = [self PixelColorAtLocation:currenttouch];
		
		CGColorRef now = NowColor.CGColor;
		const CGFloat *rgba = CGColorGetComponents(now);
		NSLog(@"now   %lf  %lf  %lf  %lf", rgba[0]*255, rgba[1]*255, rgba[2]*255, rgba[3]*255);
	
		CGColorRef front = FrontColor.CGColor;
		const CGFloat *rgba1 = CGColorGetComponents(front);
		NSLog(@"front %lf  %lf  %lf  %lf", rgba1[0]*255, rgba1[1]*255, rgba1[2]*255, rgba1[3]*255);
	
		HairColor = [UIColor colorWithRed:(76.0f/255.0f) green:(73.0f/255.0f) blue:(72.0f/255.0f) alpha:(255.0f/255.0f)];
		CGColorRef ha = HairColor.CGColor;
		const CGFloat *rgba2 = CGColorGetComponents(ha);
		NSLog(@"hair  %lf  %lf  %lf  %lf", rgba2[0]*255, rgba2[1]*255, rgba2[2]*255, rgba2[3]*255);
			
//		NSLog(@"step  %d", step);
	
		if( CGColorEqualToColor (NowColor.CGColor, HairColor.CGColor) && (step == 0) && !CGColorEqualToColor (FrontColor.CGColor, HairColor.CGColor) ) {
			BeginPoint = lasttouch;		
			step = 1;
			NSLog(@"hahahaaha");
		}	
		else if ( !CGColorEqualToColor (NowColor.CGColor, HairColor.CGColor) && (step == 1) ) {				
			
			if([cutmusic checksound]){
				[cutmusic changevolume:[cutmusic getvolume:0]];
				[cutmusic playmusic];
			}
			if(ShowRedLine != nil) {
				[ShowRedLine invalidate];
				ShowRedLine = nil;
			}
			count = 0;
			EndPoint = currenttouch; 
			[self CutHairStart:BeginPoint CutHairEnd:EndPoint];
			step = 0;
			if(end_redline == NO)
				readline ++;
			
			switch (level) {
				case 1: {
					switch (cut) {
						case 4: {
							if(readline == 2)
								end_redline = YES;
							break;
						}	
						default:
							break;
					}	
					break;
				}	
				case 2: {
					switch (cut) {
						case 1: {
							if(readline == 2)
								end_redline = YES;
							break;
						}	
						case 2: {
							if(readline == 3)
								end_redline = YES;
							break;
						}	
						case 3: {
							if(readline == 3)
								end_redline = YES;
							break;
						}	
						default:
							break;
					}	
					
					break;
				}	
				default:
					break;
			}
			if(end_redline == YES) {
				Redline.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv%d_cut%d_redline_%d.png",level,cut,readline]];
				//Tap.image = [UIImage imageNamed:@"tap_01.png"];
				[Tap startAnimating];
			}
			else {
				ShowRedLine = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(ShowRedLine:) userInfo:nil repeats:YES];
			}
			if(level == 2) {
				[Animation setAnimationImage:scissor :@"level_scissor_00" :@"png" :1 :2];
				[Animation setAndplay:scissor :1 :2];
			}
									
			//[self ShowRedline:readline];
		}
		currenttouch = lasttouch;	
	}
}
- (void) CutHairStart:(CGPoint)Begin CutHairEnd:(CGPoint)End {
	NSLog(@"CUTHAIR==========================================");
	NSLog(@"Begin point x: %lf, y: %lf",Begin.x,Begin.y);
	NSLog(@"End   point x: %lf, y: %lf",End.x,End.y);
	NSLog(@"CUTHAIR==========================================");
	
	
	if(Begin.x - End.x == 0) {
		
		if(Begin.y == End.y)
			return ;		
		if(Begin.x > 160) 
			[self ProcessImageStart:Begin End:End HighOrLow:Straight_high];
		else if(Begin.x < 160){
			[self ProcessImageStart:Begin End:End HighOrLow:Straight_low];
		}
		return ;
	}
		
	CGFloat deltaX = Begin.x - End.x;
	CGFloat deltaY = Begin.y - End.y;
	a = deltaY/deltaX;
	b = Begin.y - a * Begin.x;
	if( (a * 160 + b) == 300 ) {
		return ;
	}
	else if( (a * 160 + b) > 300 ){
		[self ProcessImageStart:Begin End:End HighOrLow:Oblique_low];
	}	
	else {
		[self ProcessImageStart:Begin End:End HighOrLow:Oblique_high];
	}
	NSLog(@"%lf   %lf",a,b);
	NSLog(@"CUTHAIR==========================================");
	return ;	
}

- (void) ProcessImageStart:(CGPoint)start End:(CGPoint)end HighOrLow:(CutType)cuttype {
	
	NSLog(@"ProcessImage=============================%lf",self.Hair.frame.size.height );
	CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
	if (cgctx == NULL) { return ; /* error */ }
	
    size_t w = CGImageGetWidth(inImage);
	size_t h = CGImageGetHeight(inImage);
	CGRect rect = {{0,0},{w,h}}; 
	
	CGContextDrawImage(cgctx, rect, inImage);
	unsigned char* data_process = CGBitmapContextGetData (cgctx);
	
	if (data_process != NULL) {
		
		
		if(cuttype == Oblique_high) {
			for(int i = 0; i < (int)self.Hair.frame.size.width; i++) {
				for (int j = 0; j < (int) self.Hair.frame.size.height; j++) {	
					if( (a * i + b) > (j + self.Hair.frame.origin.y) ) {
						int offset = 4 * (w * j + i);
						if(data_process[offset] != 0.0f) {
							if( (data_process[offset+1] == 76.0f) && (data_process[offset+2] == 73.0f) && (data_process[offset+3] == 72.0f) ) {
								data_process[offset+1] = 0.0f;
								data_process[offset+2] = 0.0f;
								data_process[offset+3] = 0.0f;
								data_process[offset] = 0.0f;
							}
						}	
					}	
				}	
			}	
		}	
		else if(cuttype == Oblique_low) {
			for(int i = 0; i < (int)self.Hair.frame.size.width; i++) {
				for (int j = 0; j < (int)self.Hair.frame.size.height; j++) {
					if( (a * i + b) < (j + self.Hair.frame.origin.y) ) {
						int offset = 4 * (w * j + i);
						if(data_process[offset] != 0.0f) {
							if( (data_process[offset+1] == 76.0f) && (data_process[offset+2] == 73.0f) && (data_process[offset+3] == 72.0f) ) {
								data_process[offset+1] = 0.0f;
								data_process[offset+2] = 0.0f;
								data_process[offset+3] = 0.0f;
								data_process[offset] = 0.0f;
							}
						}	
					}	
				}	
			}	
		}
		else if(cuttype == Straight_high) {
			for(int i = start.x; i < (int)self.Hair.frame.size.width; i++) {
				for (int j = 0; j < (int)self.Hair.frame.size.height; j++) {				
						int offset = 4 * (w * j + i);
						if(data_process[offset] != 0.0f) {
							if( (data_process[offset+1] == 76.0f) && (data_process[offset+2] == 73.0f) && (data_process[offset+3] == 72.0f) ) {
								data_process[offset+1] = 0.0f;
								data_process[offset+2] = 0.0f;
								data_process[offset+3] = 0.0f;
								data_process[offset] = 0.0f;
							}
						}							
				}	
			}		
		}	
		else if(cuttype == Straight_low) {
			for(int i = 0; i < start.x; i++) {
				for (int j = 0; j < (int)self.Hair.frame.size.height; j++) {				
					int offset = 4 * (w * j + i);
					if(data_process[offset] != 0.0f) {
						if( (data_process[offset+1] == 76.0f) && (data_process[offset+2] == 73.0f) && (data_process[offset+3] == 72.0f) ) {
							data_process[offset+1] = 0.0f;
							data_process[offset+2] = 0.0f;
							data_process[offset+3] = 0.0f;
							data_process[offset] = 0.0f;
						}
					}							
				}	
			}		
		}	
	}
	if(inImage != NULL){
		Hair.image = nil;
		CGImageRelease(inImage);
	}
	inImage =  CGBitmapContextCreateImage(cgctx);
	Hair.image = nil;
	Hair.image = [UIImage imageWithCGImage:inImage];
	CGContextRelease(cgctx);
	// Free image data memory for the context
	if (data_process) { 		
		free(data_process);
	}	
}	
- (UIColor*) PixelColorAtLocation:(CGPoint)point {
	
	UIColor* color = nil;
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
	if (cgctx == NULL) { return nil; /* error */ }
	
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
		
		int offset = 4 * ((w * (point.y - self.frame.origin.y - self.Hair.frame.origin.y)) + (point.x - self.frame.origin.x));
		int alpha =  data[offset];
		int red = data[offset+1];
		int green = data[offset+2];
		int blue = data[offset+3];
		
//		NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
		color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
		//NSLog(@"x: %lf, y: %lf",point.x,point.y);
	}
	 CGContextRelease(cgctx);
	
	if (data) { 		
		free(data);
	}	
	return color;
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

- (void) ShowRedLine:(NSTimer*) timer {
		
	//UIImageView *redline = ((UIImageView*) timer.userInfo);	
	NSString *filepath;
	//NSLog(@"SSSSSSSSSSSSSSSSShowRedLine %d,%d",level,cut);
	filepath = [NSString stringWithFormat:@"lv%d_cut%d_redline_%d.png",level,cut,readline];
	/*line = [UIImage imageNamed:tmp];
	Redline.image = line;*/
	printf("********************************");
//	NSLog(filepath);
	printf("****************************************");
	UIImage *tmp = [UIImage imageNamed:filepath];
	
	if(tmp != nil && [timer isValid]) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[array addObject:tmp];
		[array addObject:[UIImage imageNamed:@"Nil.png"]];
		Redline.animationImages = array;
		Redline.animationDuration = 0.4;
		Redline.animationRepeatCount = 1;
		[array release];
		[Redline startAnimating];
	}	
	//	NSLog(@"Timer stoppppppppppppppppppppppppppppppppppppp");
}	
- (void)dealloc {
	[checkbutton release];
	[drawImage release];
	[picImageview release];
	[picImage release];
	[bgphoto release];
	[Body release];
	[Hair release];
	[Redline release];
	[body release];
	[hair release];
	[line release];
	[ShowRedLine release];
	[tip release];
	[bubble release];
	[scissor release];
	[Tap release];
    [super dealloc];
}

@end
