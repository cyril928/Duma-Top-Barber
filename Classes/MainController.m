//
//  MainController.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/5.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "MainController.h"
#import "ChooseLevel.h"
#import "Practice.h"
#import "Option.h"
#import "Free.h"
#import "Start.h"
#import "Animation.h"

@implementation MainController
@synthesize chooselevelbutton, optionbutton, practicebutton, fullbutton;
@synthesize levelpage, practicepage, freepage, optionpage, fram, mainpage;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
-(NSString *) datafilepath{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:levelfile];
}
-(void) reload{
	//NSString *filepath = [self datafilepath];
	mainpage.image=[UIImage imageNamed:@"select_p_bg.png"];
	/*if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
		if ([[array objectAtIndex:0]intValue]>=4) {
			mainpage.image=[UIImage imageNamed:@"select_p_bg_shopunlock.png"];
		}
		[array release];
	}*/
	[Animation setAnimationImage:fram :@"select_p_bg_line_" :@"png" :1 :2];
	[Animation setAndplay:fram :0.4 :0];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Main Page";
	[super viewDidLoad];
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
	[mainpage release];
	[fram release];
	[chooselevelbutton release];
	[practicebutton release];
	[optionbutton release];
	[fullbutton release];
    [super dealloc];
}

-(IBAction) pressplay{
	[self playclick];
	if(levelpage == nil){
		levelpage = [[ChooseLevel alloc] initWithNibName:@"ChooseLevel" bundle:nil];
	}else {
		[levelpage reload];
	}

	[fram stopAnimating];
	[self.navigationController pushViewController:levelpage animated:YES];
}

-(IBAction) presspractice{
	/*if(practicepage ==nil ){
		practicepage = [[Practice alloc] initWithNibName:@"Practice" bundle:nil];
	}
	[self.navigationController pushViewController:practicepage animated:YES];
	 */
}
	  
-(IBAction) pressfull{
	/*if(freepage ==nil ){
		freepage = [[Free alloc] initWithNibName:@"Free" bundle:nil];
	}
	[self.navigationController pushViewController:freepage animated:YES];
	 */
}
  
-(IBAction) pressoption{
	[self playclick];
	if(optionpage ==nil ){
		optionpage = [[Option alloc] initWithNibName:@"Option" bundle:nil];
	}else {
		[optionpage reload];
	}

	[self.navigationController pushViewController:optionpage animated:YES];
}
-(IBAction) back{
	[self playclick];
	NSArray *array = self.navigationController.viewControllers;
	Start *tmp = [array objectAtIndex:0];
	[tmp reload];
	[self.navigationController popViewControllerAnimated:YES];
}


@end
