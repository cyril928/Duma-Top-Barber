//
//  ChooseLevel.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/12.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "ChooseLevel.h"
#import "MainController.h"

@implementation ChooseLevel
@synthesize level1;
@synthesize level2;
@synthesize level3;
@synthesize level4;
@synthesize playcontroller;
@synthesize catchplay;
@synthesize waveplay;
@synthesize lvchange;
@synthesize debuglv;
@synthesize frame;
@synthesize level;
@synthesize line;
@synthesize hw,hwbg,nextbutton;


-(NSString *) datafilepath{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:levelfile];
}
-(NSString *) howto{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:howtofile];
}
-(void) reloadlevel{
	hwbg.hidden=YES;
	hw.hidden=YES;
	filepath = [self datafilepath];
	/*if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
		lvchange.value = [[array objectAtIndex:0] intValue];
		debuglv.text = [NSString stringWithFormat:@"%.0lf",lvchange.value];
		level1.hidden = ![[array objectAtIndex:1] boolValue];
		level2.hidden = ![[array objectAtIndex:2] boolValue];
		level3.hidden = ![[array objectAtIndex:3] boolValue];
		level4.hidden = ![[array objectAtIndex:4] boolValue];
		int i;
		for (i=4; i>0 ; i--) {
			if ([[array objectAtIndex:i] boolValue]) {
				break;
			}
		}
		level.image = [UIImage imageNamed:[NSString stringWithFormat:@"level_select_lv%d.png",i]];
		[array release];
	}*/
	level.image = [UIImage imageNamed:@"game_select_word.png"];
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

-(void) reload{
	[Animation setAnimationImage:frame :@"level_select_line_00" :@"png" :1 :4];
	[Animation setAndplay:frame :0.3 :0];
	
	/*[Animation setAnimationImage:line :@"level_select_line_01_00": @"png" :1 :2];
	[Animation setAndplay:line :0.3 :0];*/
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	debuglv.hidden=YES;
	lvchange.hidden=YES;
	[super viewDidLoad];
	playcontroller = [[PlayView alloc] initWithNibName:@"Play" bundle:nil];
	hwbg.image=[UIImage imageNamed:@"option_htp_bg.png"];
	hwbg.hidden=YES;
	hw.hidden=YES;
	nextbutton.hidden=YES;
	[self reloadlevel];
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
-(BOOL) howtochange:(int) lv{
	BOOL lvtmp;
	filepath = [self howto];
	if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
		NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:filepath];
		lvtmp=[[array objectAtIndex:lv-1] boolValue];
		if (!lvtmp) {
			[array replaceObjectAtIndex:lv-1 withObject:[NSNumber numberWithBool:YES]];
			[array writeToFile:filepath atomically:YES];
			[array release];
			return NO;
		}
	}
	return YES;
}
-(IBAction) changelv{
	float i=0;
	filepath = [self datafilepath];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	int lvnow = lvchange.value;
	NSNumber *lv = [NSNumber numberWithInt:lvnow];
	[array addObject:lv];
	debuglv.text = [NSString stringWithFormat:@"%d",lvnow];
	for (i=0; i<lvnow; i++) {
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
	[self reloadlevel];
}
-(void)nextphoto{
	nextcount++;
	switch (nextcount) {
		case 1:
			[nextbutton setImage:[UIImage imageNamed:@"option_htp_next_0001.png"] forState:0];
			break;
		case 2:
			[nextbutton setImage:[UIImage imageNamed:@"option_htp_next_0002.png"] forState:0];
			nextcount=0;
			break;
			
		default:
			break;
	}
}
-(IBAction) nextpress{
	[self playclick];
	presscount++;
	printf("%d\n",presscount);
	if(presscount==1){
		NSMutableArray *array = [[NSMutableArray alloc]init];
		[array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"option_htp_lv%d_2.png",chlv]]];
		[array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"option_htp_lv%d_3.png",chlv]]];
		hw.animationImages=array;
		hw.animationDuration=1;
		hw.animationRepeatCount=0;
		[hw startAnimating];
	}else if (presscount>=2) {
		//hw.hidden=YES;
		[nexttimer invalidate];
		//hwbg.hidden=YES;
		nextbutton.hidden=YES;
		if (chlv==1) {
			[self.navigationController pushViewController:playcontroller animated:YES];
		}
		if (chlv==3) {
			[waveplay reload];
			if (waveplay == nil) {
				waveplay = [[Waveplay alloc] initWithNibName:@"Waveplay" bundle:nil];	
			}
			[self.navigationController pushViewController:waveplay animated:YES];			
		}
		if (chlv==4) {
			if (catchplay == nil) {
				catchplay = [[Catchplay alloc] initWithNibName:@"CatchView" bundle:nil]; 
			}else {
				[catchplay restart];
			}
			[self.navigationController pushViewController:catchplay animated:YES];
		}
	}
}
-(IBAction) playlv1{
	[self playclick];
	[playcontroller setlv:1];
	[playcontroller reload];
	if([self howtochange:1]){
		[self.navigationController pushViewController:playcontroller animated:YES];
	}else {
		chlv=1;
		nextcount=0;
		presscount=0;
		hwbg.hidden=NO;
		hw.hidden=NO;
		nextbutton.hidden=NO;
		hw.image= [UIImage imageNamed:@"option_htp_lv1_1.png"];
		[hw stopAnimating];
		nexttimer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(nextphoto) userInfo:nil repeats:YES];
	}
}
-(IBAction) playlv3{
	[self playclick];
	if([self howtochange:3]){
		[waveplay reload];
		if (waveplay == nil) {
			waveplay = [[Waveplay alloc] initWithNibName:@"Waveplay" bundle:nil];	
		}
		[self.navigationController pushViewController:waveplay animated:YES];
	}else {
		chlv=3;
		nextcount=0;
		presscount=0;
		hwbg.hidden=NO;
		hw.hidden=NO;
		nextbutton.hidden=NO;
		hw.image= [UIImage imageNamed:@"option_htp_lv3_1.png"];
		[hw stopAnimating];
		nexttimer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(nextphoto) userInfo:nil repeats:YES];
	}
}
-(IBAction) playlv4{
	[self playclick];
	if([self howtochange:4]){
		if (catchplay == nil) {
			catchplay = [[Catchplay alloc] initWithNibName:@"CatchView" bundle:nil]; 
		}else {
			[catchplay restart];
		}
		[self.navigationController pushViewController:catchplay animated:YES];
	}else {
		chlv=4;
		nextcount=0;
		presscount=0;
		hwbg.hidden=NO;
		hw.hidden=NO;
		nextbutton.hidden=NO;
		hw.image= [UIImage imageNamed:@"option_htp_lv4_1.png"];
		[hw stopAnimating];
		nexttimer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(nextphoto) userInfo:nil repeats:YES];
	}
}
-(IBAction) back{
	if (nextbutton.hidden) {
		[self playclick];
		NSArray *array = self.navigationController.viewControllers;
		MainController *tmp = [array objectAtIndex:1];
		[tmp reload];
		[super back];
	}else {
		[hw stopAnimating];
		hw.hidden=YES;
		[nexttimer invalidate];
		hwbg.hidden=YES;
		nextbutton.hidden=YES;
	}
	
}
- (void)dealloc {
	[line release];
	[level release];
	[frame release];
	[level1 release];
	[level2 release];
	[level3 release];
	[level4 release];
	[lvchange release];
	[debuglv release];
	[catchplay release];
	[waveplay release];
	[backbutton release];
    [super dealloc];
}
@end
