//
//  Option.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/12.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "Option.h"
#import "MainController.h"


@implementation Option
@synthesize howtoplay;
@synthesize howto;
@synthesize volume;
@synthesize frame;
@synthesize howcount;
@synthesize soundon;
@synthesize soundoff;
@synthesize vibrationon;
@synthesize vibrationoff;
@synthesize sound;
@synthesize howtotimer;
@synthesize vib;
@synthesize clickvolume;
@synthesize playvolume;

-(NSString *) datafilepath{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:switchfile];
}
-(IBAction) presssoundon{
	sound = YES;
	[soundon setImage:[UIImage imageNamed:@"option_on_red.png"] forState:0];
	[soundoff setImage:[UIImage imageNamed:@"option_off_green.png"] forState:0];
	[self save];
	[self playclick];
}
-(IBAction) presssoundoff{
	sound = NO;
	[soundon setImage:[UIImage imageNamed:@"option_on_green.png"] forState:0];
	[soundoff setImage:[UIImage imageNamed:@"option_off_red.png"] forState:0];
	[self save];
	[self playclick];
}
-(IBAction) pressvibon{
	vib = YES;
	[vibrationon setImage:[UIImage imageNamed:@"option_on_red.png"] forState:0];
	[vibrationoff setImage:[UIImage imageNamed:@"option_off_green.png"] forState:0];
	[self save];
	[self playclick];
}
-(IBAction) pressviboff{
	vib = NO;
	[vibrationon setImage:[UIImage imageNamed:@"option_on_green.png"] forState:0];
	[vibrationoff setImage:[UIImage imageNamed:@"option_off_red.png"] forState:0];
	[self save];
	[self playclick];
}
-(IBAction) playvolumechange{
	[self save];
}
-(IBAction) clickvolumechange{
	[self save];
}
-(void) save{
	NSNumber *sd = [NSNumber numberWithBool:sound];
	NSNumber *vb = [NSNumber numberWithBool:vib];
	NSNumber *sv = [NSNumber numberWithFloat:playvolume.value];
	NSNumber *mv = [NSNumber numberWithFloat:clickvolume.value];
	filepath = [self datafilepath];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:sd];
	[array addObject:vb];
	[array addObject:sv];
	[array addObject:mv];
	[array writeToFile:filepath atomically:YES];
	[array release];
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

-(void) reloadswitch{
	filepath = [self datafilepath];
	if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
		sound = [[array objectAtIndex:0] boolValue];
		vib = [[array objectAtIndex:1] boolValue];
		playvolume.value = [[array objectAtIndex:2] floatValue];
		clickvolume.value = [[array objectAtIndex:3] floatValue];
		[array release];
	}else {
		sound = YES;
		vib = YES;
	}
	if (sound) {
		[soundon setImage:[UIImage imageNamed:@"option_on_red.png"] forState:0];
		[soundoff setImage:[UIImage imageNamed:@"option_off_green.png"] forState:0];
	}else {
		[soundon setImage:[UIImage imageNamed:@"option_on_green.png"] forState:0];
		[soundoff setImage:[UIImage imageNamed:@"option_off_red.png"] forState:0];
	}
	if (vib) {
		[vibrationon setImage:[UIImage imageNamed:@"option_on_red.png"] forState:0];
		[vibrationoff setImage:[UIImage imageNamed:@"option_off_green.png"] forState:0];
	}else {
		[vibrationon setImage:[UIImage imageNamed:@"option_on_green.png"] forState:0];
		[vibrationoff setImage:[UIImage imageNamed:@"option_off_red.png"] forState:0];
	}
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	[self reloadswitch];
}

-(void) reload{
	[Animation setAnimationImage:frame :@"option_htp_line_00" :@"png" :2 :3];
	[Animation setAndplay:frame :0.3 :0];
	howtotimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(nexthowto) userInfo:nil repeats:YES];	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[playvolume setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
	[playvolume setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateHighlighted];
	[playvolume setMinimumTrackImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
	[playvolume setMaximumTrackImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
	[clickvolume setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
	[clickvolume setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateHighlighted];
	[clickvolume setMinimumTrackImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
	[clickvolume setMaximumTrackImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
	[self reload];
}

-(void) nexthowto{
	howcount++;
	switch (howcount) {
		case 1:
			[howtoplay setImage:[UIImage imageNamed:@"option_htp_w_0001.png"] forState:0];
			break;
		default:
			[howtoplay setImage:[UIImage imageNamed:@"option_htp_w_0002.png"] forState:0];
			howcount=0;
			break;
	}
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
	[howtotimer release];
	[frame release];
	[filepath release];
	[soundon release];
	[soundoff release];
	[vibrationon release];
	[vibrationoff release];
    [super dealloc];
}
-(IBAction) back{
	[self playclick];
	frame.animationImages = nil;
	[howtotimer invalidate];
	NSArray *array = self.navigationController.viewControllers;
	MainController *tmp = [array objectAtIndex:1];
	[tmp reload];
	[super back];
}

-(IBAction) howtopress{
	[self playclick];
	if ([howtotimer isValid]) {
		[howtotimer invalidate];
		howtotimer=nil;
	}
	if (howto == nil) {
		howto = [[howtoplayview alloc] initWithNibName:@"HowTo" bundle:nil];
	}else {
		[howto reload];
	}
	
	[self.navigationController pushViewController:howto animated:YES];
}

@end
