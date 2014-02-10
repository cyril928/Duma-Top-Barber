    //
//  howtoplayview.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/30.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "howtoplayview.h"
#import "Option.h"

@implementation howtoplayview
@synthesize show;
@synthesize count;
@synthesize nextcount;
@synthesize nextbutton;
@synthesize fram;
@synthesize but,lv1,lv3,lv4,bgphoto;

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

-(void) reload{
	cannext=NO;
	nextbutton.hidden=YES;
	show.image = [UIImage imageNamed:@"option_htp_select_lv.png"];
	[Animation setAnimationImage:fram :@"option_htp_line_00" :@"png" :2 :3];
	[Animation setAndplay:fram :0.3 :0];
	but = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(nextphoto) userInfo:nil repeats:YES];	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self reload];
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
-(IBAction) lv1press{
	[self playclick];
	nextbutton.hidden=NO;
	count=0;
	chooselevel=1;
	cannext=YES;
	show.image=[UIImage imageNamed:@"option_htp_lv1_1.png"];
	NSMutableArray *array = [[NSMutableArray alloc]init];
	[array addObject:[UIImage imageNamed:@"option_htp_lv1_2.png"]];
	[array addObject:[UIImage imageNamed:@"option_htp_lv1_3.png"]];
	show.animationImages=array;
	show.animationDuration=1;
	show.animationRepeatCount=0;
}
-(IBAction) lv3press{
	[self playclick];
	nextbutton.hidden=NO;
	count=0;
	chooselevel=3;
	cannext=YES;
	show.image=[UIImage imageNamed:@"option_htp_lv3_1.png"];
	NSMutableArray *array = [[NSMutableArray alloc]init];
	[array addObject:[UIImage imageNamed:@"option_htp_lv3_2.png"]];
	[array addObject:[UIImage imageNamed:@"option_htp_lv3_3.png"]];
	show.animationImages=array;
	show.animationDuration=1;
	show.animationRepeatCount=0;
}
-(IBAction) lv4press{
	[self playclick];
	nextbutton.hidden=NO;
	count=0;
	chooselevel=4;
	cannext=YES;
	show.image=[UIImage imageNamed:@"option_htp_lv4_1.png"];
	NSMutableArray *array = [[NSMutableArray alloc]init];
	[array addObject:[UIImage imageNamed:@"option_htp_lv4_2.png"]];
	[array addObject:[UIImage imageNamed:@"option_htp_lv4_3.png"]];
	show.animationImages=array;
	show.animationDuration=1;
	show.animationRepeatCount=0;
}

- (void)dealloc {
	[lv1 release];
	[lv3 release];
	[lv4 release];
	[but release];
	[show release];
	[fram release];
	[nextbutton release];
    [super dealloc];
}
-(IBAction) back{
	[self playclick];
	if (cannext) {
		show.animationImages=nil;
		cannext=NO;
		nextbutton.hidden=YES;
		show.image=[UIImage imageNamed:@"option_htp_select_lv.png"];
	}else{
		[self playclick];
		[but invalidate];
		NSArray *array = self.navigationController.viewControllers;
		Option *tmp = [array objectAtIndex:[array count]-2];
		[tmp reload];
		fram.animationImages=nil;
		[super back];
	}
}
-(void) lv1photo{
	count++;
	switch (count) {
		case 0:
			[show stopAnimating];
			show.image = [UIImage imageNamed:[NSString stringWithFormat:@"option_htp_lv%d_1.png",chooselevel]];
			break;
		case 1:
			[show startAnimating];
			nextbutton.hidden=YES;
			break;
		default:
			break;
	}
}
-(IBAction) nextpage{
	[self playclick];
	if(cannext){
		[self playclick];
		[self lv1photo];
	}
}

@end
