    //
//  Start.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/1.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "Start.h"
#import "MainController.h"

@implementation Start
@synthesize startbutton;
@synthesize startpage;
@synthesize mainpage;
@synthesize count;
@synthesize startcount;
@synthesize button;
@synthesize photo;
@synthesize lite;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
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
-(NSString *) datafilepathscore{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:scorefile];
}
-(NSString *) datafilepathlv{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:levelfile];
}
-(NSString *) datafilepathsd{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:switchfile];
}
-(NSString *) howto{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:howtofile];
}
-(IBAction) changelv{
	float i=0;
	NSString *filepath = [self datafilepathlv];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	NSNumber *lv = [NSNumber numberWithInt:1];
	[array addObject:lv];
	for (i=0; i<1; i++) {
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
}
-(void) changesd{
	NSString *filepath = [self datafilepathsd];
	NSNumber *sd = [NSNumber numberWithBool:YES];
	NSNumber *vb = [NSNumber numberWithBool:YES];
	NSNumber *sv = [NSNumber numberWithFloat:1.0];
	NSNumber *mv = [NSNumber numberWithFloat:1.0];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:sd];
	[array addObject:vb];
	[array addObject:sv];
	[array addObject:mv];
	[array writeToFile:filepath atomically:YES];
	[array release];
}
-(void) changescore {
	NSString *filepath = [self datafilepathscore];
	NSNumber *score = [NSNumber numberWithInt:0];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:score];
	[array writeToFile:filepath atomically:YES];
	[array release];
}	
-(void) changehw{
	float i=0;
	NSString *filepath = [self howto];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (i=0; i<4; i++) {
		NSNumber *tmp = [NSNumber numberWithBool:NO];
		[array addObject:tmp];
		[tmp release];
	}
	[array writeToFile:filepath atomically:YES];
	[array release];
}
-(void)initfile{
	NSString *filepathlv = [self datafilepathlv];
	if(![[NSFileManager defaultManager] fileExistsAtPath:filepathlv]){
		[self changelv];
	}
	NSString *filepathsd = [self datafilepathsd];
	if(![[NSFileManager defaultManager] fileExistsAtPath:filepathsd]){
		[self changesd];
	}
	NSString *filepathscore = [self datafilepathscore];
	if(![[NSFileManager defaultManager] fileExistsAtPath:filepathscore]){
		[self changescore];
	}
	NSString *filepathhowto = [self howto];
	if(![[NSFileManager defaultManager] fileExistsAtPath:filepathhowto]){
		[self changehw];
	}
}
-(void) memelogo: (NSTimer *) timer{
	NSString *tmp;
	startcount++;
	if(startcount < 10){
		tmp = [NSString stringWithFormat:@"logo_memes_000%d.jpg",startcount];
	}else
		tmp = [NSString stringWithFormat:@"logo_memes_00%d.jpg",startcount];
	startpage.image = [UIImage imageNamed:tmp];
	if (startcount>73) {
		startcount=0;
		startbutton.hidden=NO;
		lite.hidden = NO;
		[self reload];
		[timer invalidate];
	}
}

-(void) reload{
	lite.hidden=YES;
	button = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(stph) userInfo:nil repeats:YES];
	photo = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(stview) userInfo:nil repeats:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initfile];
	startbutton.hidden=YES;
	lite.hidden = YES;
	click = [[PMusic alloc] initWithFileName:@"Click"];
	[NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(memelogo:) userInfo:nil repeats:YES];
}

-(void) stph{
	switch (count) {
		case 0:
			[startbutton setImage:[UIImage imageNamed:@"press_start_word.png"] forState:0];
			count++;
			break;
		default:
			[startbutton setImage:nil forState:0];
			count = 0;
			break;
	}
}
-(void) stview{
	NSString *tmp;
	startcount++;
	tmp = [NSString stringWithFormat:@"PS%d.jpg",startcount];
	startpage.image = [UIImage imageNamed:tmp];
	if (startcount>=37) {
		startcount=9;
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[click release];
	[mainpage release];
	[startbutton release];
	[startpage release];
    [super dealloc];
}
-(void) playclick{
	if ([click checksound]) {
		[click changevolume:[click getvolume:1]];
		[click playmusic];
	}
}
- (IBAction) pressstart{
	[self playclick];
	if (mainpage ==nil ) {
		mainpage = [[MainController alloc] initWithNibName:@"Main" bundle:nil];
	}
	NSLog(@"gogogo");
	[button invalidate];
	[photo invalidate];
	[self.navigationController pushViewController:mainpage animated:YES];
}

@end
