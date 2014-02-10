    //
//  Catchplay.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/7.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "Catchplay.h"
#import "ChooseLevel.h"


@implementation Catchplay
@synthesize pic01, pic02, pic03, pic04, pic05, pic06;
@synthesize duma;
@synthesize hair;
@synthesize tips,cake,time,cane,coloritem,dropitem,dropcolor,line;
@synthesize item0,item1,item2,item3,item4,pausepage,resumebutton,Pausebutton;
@synthesize score;
@synthesize N0,N1,N2,N3,N4,N5,N6,N7,N8,N9,Score_Continue,Score_Show,pic_path;
@synthesize Score_Frame,Frame;
@synthesize second1, second0, min1;
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

-(void)picgen:(UIImageView*) pic {
	int r = arc4random() % 320;
	//NSLog(@"%d",r);
	if (r<pic.frame.size.width/2) {
		r = pic.frame.size.width/2;
	}
	if (r>320-pic.frame.size.width/2) {
		r = 320-pic.frame.size.width/2;
	}
	pic.center =CGPointMake(r, pic.frame.size.height/2);
}
-(void) resetflag{
	int i;
	finalcolor[0]=0;
	finalcolor[1]=0;
	color[0]=0;
	color[1]=0;
	totalrandomfix=0;
	for (i=0; i<7; i++) {
		a[i]=0;
		picarray[i].image=nil;
		picarray[i].animationRepeatCount=0;
	}
	for (i=0; i<5; i++) {
		randomfix[i]=0;
		distancex[i]=0;
		finalitem[i]=0;
	}
}
-(void)timecost{
	if(pausebool){
		second--;
		if (second<0 && min>0) {
			second=59;
			min--;
		}
		min1.image=[UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",min]];
		second1.image=[UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",second/10]];
		second0.image=[UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",second%10]];
		if (min<=0 && second<=0) {
			pausebool=NO;
			pausepage.hidden = NO;
			Pausebutton.hidden = YES;
			[Animation setAnimationImage:pausepage :@"check_timeout" :@"png" :1 :2];
			[Animation setAndplay:pausepage :1 :2];
			pic_path = [NSString stringWithString:@"check_timeout.png"];
			[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(backpageani) userInfo:nil repeats:NO];
		}
	}
}
-(void)backpageani{
	pausebool=NO;
	pausepage.hidden = YES;
	Score_Show = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(Score_Show:) userInfo:nil repeats:YES];
	//[self back];
}
- (void) Score_Show:(NSTimer *) timer {
	Score_Continue.hidden = NO;
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
	//[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(back) userInfo:nil repeats:NO];
}
-(void) start{
	Pausebutton.hidden=NO;
	
	pausepage.image = nil;
	min=1;
	second=30;
	min1.image=[UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",min]];
	second1.image=[UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",second/10]];
	second0.image=[UIImage imageNamed:[NSString stringWithFormat:@"time_nb_%d.png",second%10]];
	[self setstyle:1];
	pausebool=YES;
	direction=0;
	pausepage.hidden=YES;
	resumebutton.hidden=YES;
	backbutton.hidden=YES;
	time=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timecost) userInfo:nil repeats:YES];
	dropitem = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(drop) userInfo:nil repeats:YES];
	dropcolor = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(colordrop) userInfo:nil repeats:YES];	
	pictimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(fall) userInfo:nil repeats:YES];
	colortimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(fallcolor) userInfo:nil repeats:YES];
}
-(void) restart{
	pausebool=YES;
	resumebutton.hidden=YES;
	backbutton.hidden=YES;
	Score_Continue.hidden=YES;
	pausepage.hidden=NO;
	Pausebutton.hidden=YES;
	pausepage.image = [UIImage imageNamed:@"lv4_start_page.png"];
	[Animation setAnimationImage:line :@"lv4_start_page_line_" :@"png" :1 :2];
	[Animation setAndplay:line :0.5 :4];
	playmusic = [[PMusic alloc] initWithFileName:@"PlayMusic"];
	if ([playmusic checksound]) {
		[playmusic changevolume:[playmusic getvolume:0]];
		[playmusic setinfinloop];
		[playmusic playmusic];
	}
	[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(start) userInfo:nil repeats:NO];
}
-(void) setstyle:(int)st{
	[self resetflag];
	style = st;
	item0.image=nil;
	item1.image=nil;
	item2.image=nil;
	item3.image=nil;
	item4.image=nil;
	tips.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv4_tips_0%d.png",style]];
	hair.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv4_none.png"]];
	switch (style) {
		case 1:
			[dropingname release];
			[dropingphoto release];
			dropingname = [[NSMutableArray alloc] init];
			dropingphoto = [[NSMutableArray alloc] init];
			[dropingphoto addObject:[UIImage imageNamed:@"item12.png"]];
			[dropingname addObject:[NSNumber numberWithInt:12]];
			[dropingphoto addObject:[UIImage imageNamed:@"item6.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			[dropingphoto addObject:[UIImage imageNamed:@"item3.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			[dropingphoto addObject:[UIImage imageNamed:@"item9.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			[dropingphoto addObject:[UIImage imageNamed:@"item2.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			finalitemcount=1;
			finalcolorcount=1;
			distancex[0]=29;
			finalcolor[0]=1;
			finalitem[0]=12;
			item0.center=CGPointMake(hair.center.x+distancex[0], hair.center.y);
			break;
		case 2:
			[dropingname release];
			[dropingphoto release];
			dropingname = [[NSMutableArray alloc] init];
			dropingphoto = [[NSMutableArray alloc] init];
			[dropingphoto addObject:[UIImage imageNamed:@"item12.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			[dropingphoto addObject:[UIImage imageNamed:@"item1.png"]];
			[dropingname addObject:[NSNumber numberWithInt:1]];
			[dropingphoto addObject:[UIImage imageNamed:@"item2.png"]];
			[dropingname addObject:[NSNumber numberWithInt:2]];
			[dropingphoto addObject:[UIImage imageNamed:@"item6.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			[dropingphoto addObject:[UIImage imageNamed:@"item9.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			finalitemcount=2;
			finalcolorcount=2;
			distancex[1]=36;
			distancex[2]=-36;
			finalcolor[0]=3;
			finalcolor[1]=2;
			finalitem[1]=1;
			finalitem[2]=2;
			item1.center=CGPointMake(hair.center.x+distancex[1], hair.center.y-13);
			item2.center=CGPointMake(hair.center.x+distancex[2], hair.center.y-5);
			break;
		case 3:
			[dropingname release];
			[dropingphoto release];
			dropingname = [[NSMutableArray alloc] init];
			dropingphoto = [[NSMutableArray alloc] init];
			[dropingphoto addObject:[UIImage imageNamed:@"item10.png"]];
			[dropingname addObject:[NSNumber numberWithInt:10]];
			[dropingphoto addObject:[UIImage imageNamed:@"item1.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			[dropingphoto addObject:[UIImage imageNamed:@"item7.png"]];
			[dropingname addObject:[NSNumber numberWithInt:7]];
			[dropingphoto addObject:[UIImage imageNamed:@"item6.png"]];
			[dropingname addObject:[NSNumber numberWithInt:0]];
			[dropingphoto addObject:[UIImage imageNamed:@"item4.png"]];
			[dropingname addObject:[NSNumber numberWithInt:4]];
			finalcolorcount=2;
			finalitemcount=3;
			distancex[0]=-34;
			distancex[1]=36;
			finalcolor[0]=1;
			finalcolor[1]=3;
			finalitem[0]=4;
			finalitem[1]=7;
			finalitem[2]=10;
			item0.center=CGPointMake(hair.center.x+distancex[0], hair.center.y);
			item1.center=CGPointMake(hair.center.x+distancex[1], hair.center.y-10);
			item2.center=CGPointMake(hair.center.x+distancex[2], hair.center.y-35);
			break;
		case 4:
			[dropingname release];
			[dropingphoto release];
			dropingname = [[NSMutableArray alloc] init];
			dropingphoto = [[NSMutableArray alloc] init];
			[dropingphoto addObject:[UIImage imageNamed:@"item10.png"]];
			[dropingname addObject:[NSNumber numberWithInt:10]];
			[dropingphoto addObject:[UIImage imageNamed:@"item2.png"]];
			[dropingname addObject:[NSNumber numberWithInt:2]];
			[dropingphoto addObject:[UIImage imageNamed:@"item5.png"]];
			[dropingname addObject:[NSNumber numberWithInt:5]];
			[dropingphoto addObject:[UIImage imageNamed:@"item11.png"]];
			[dropingname addObject:[NSNumber numberWithInt:11]];
			[dropingphoto addObject:[UIImage imageNamed:@"item12.png"]];
			[dropingname addObject:[NSNumber numberWithInt:12]];
			finalitemcount=5;
			finalcolorcount=2;
			distancex[0]=-32;
			distancex[1]=-22;
			distancex[2]=22;
			distancex[3]=33;
			finalcolor[0]=2;
			finalcolor[1]=1;
			finalitem[0]=12;
			finalitem[1]=10;
			finalitem[2]=2;
			finalitem[3]=5;
			finalitem[4]=11;
			item0.center=CGPointMake(hair.center.x+distancex[0], hair.center.y+13);
			item1.center=CGPointMake(hair.center.x+distancex[1], hair.center.y-35);
			item2.center=CGPointMake(hair.center.x+distancex[2], hair.center.y-35);
			item3.center=CGPointMake(hair.center.x+distancex[3], hair.center.y+7);
			item4.center=CGPointMake(hair.center.x+distancex[4], hair.center.y);
			break;
		default:
			break;
	}
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	Score_Continue.hidden = YES;
	pic_path = nil;
	picarray[0]=pic01;
	picarray[1]=pic02;
	picarray[2]=pic03;
	picarray[3]=pic04;
	picarray[4]=pic05;
	picarray[5]=pic06;
	picarray[6]=coloritem;
	item[0]=item0;
	item[1]=item1;
	item[2]=item2;
	item[3]=item3;
	item[4]=item4;

	dumapace=1;
	UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = self;
    accelerometer.updateInterval =  kUpdateInterval;

	style=1;
	rightmusic = [[PMusic alloc] initWithFileName:@"right"];
	[self resetflag];
	[self restart];
	[super viewDidLoad];
}
-(void) colordrop{
	NSString *tmp;
	int colornum;
	if (pausebool) {
		if (direction==0) {
			if (cane.center.x+cane.frame.size.width/2+1<320) {
				cane.center = CGPointMake(cane.center.x+1, cane.center.y);
			}else {
				direction=1;
			}
		}else {
			if (cane.center.x-cane.frame.size.width/2-1>0) {
				cane.center = CGPointMake(cane.center.x-1, cane.center.y);
			}else {
				direction=0;
			}
		}
		colorchoose++;
		if (colorchoose<100) {
			cane.image = [UIImage imageNamed:@"lv4_dc_colorcan_1.png"];
			colornum=0;
		}else if (colorchoose<=200) {
			cane.image = [UIImage imageNamed:@"lv4_dc_colorcan_2.png"];
			colornum=1;
		}else if (colorchoose<=300) {
			cane.image = [UIImage imageNamed:@"lv4_dc_colorcan_3.png"];
			colornum=2;
		}else if (colorchoose<=400) {
			colorchoose=0;
		}
		if (a[6]==0) {
			a[6]=1;
			coloritem.center=CGPointMake(cane.center.x,72);
			tmp = [NSString stringWithFormat:@"color%d.png",colornum+1];
			coloritem.image = [UIImage imageNamed:tmp];
			coloritem.animationRepeatCount = colornum+1;
		}
	}
}
-(void) fallcolor{
	int tmp = picarray[6].animationRepeatCount;
	if (pausebool) {
		if (a[6]==1) {
			if (picarray[6].center.y+1+picarray[6].frame.size.height/2>435) {
				picarray[6].image=nil;
				a[6]=0;
			}else {
				picarray[6].center = CGPointMake(picarray[6].center.x, picarray[6].center.y+1);
			}
			int hcheck = (hair.center.y-hair.frame.size.height/2)-(picarray[6].center.y+picarray[6].frame.size.height/2);
			int wcheck =  abs(hair.center.x - picarray[6].center.x);
			if (wcheck <= hair.frame.size.width/2 + picarray[6].frame.size.width/3  &&  hcheck<=0 && hcheck>=-25) {
				picarray[6].image = nil;
				a[6]=0;
				[self cgcolor:tmp];
			}
		}
	}
}
-(void)cgcolor:(int)tmp{
	int i;
	NSString *tmpimage;
	for (i=0; i<2; i++) {
		if (finalcolor[i]==tmp && tmp!=0) {
			finalcolorcount--;
			color[i]=tmp;
			finalcolor[i]=0;
			tmpimage = [NSString stringWithFormat:@"lv4_%d_head_%d%d.png",style,color[0],color[1]];
			hair.image=[UIImage imageNamed:tmpimage];
			break;
		}
	}
	[self checkcorrect];
}
-(void) drop{
	int i;
	if (pausebool) {
		int enabledrop = arc4random() %5;
		if (enabledrop < 10) {
			int dropingitem = arc4random() % 5;
			while (randomfix[dropingitem]==2) {
				dropingitem = arc4random() % 5;
			}
			randomfix[dropingitem]++;
			totalrandomfix++;
			if (totalrandomfix>=10) {
				totalrandomfix=0;
				randomfix[0]=0;
				randomfix[1]=0;
				randomfix[2]=0;
				randomfix[3]=0;
				randomfix[4]=0;
			}
			for (i=0; i<6; i++) {
				if (a[i]==0) {
					a[i]=1;
					//printf("%d\n",dropingitem);
					[self picgen:picarray[i]];
					picarray[i].image = [dropingphoto objectAtIndex:dropingitem];
					picarray[i].animationRepeatCount = dropingitem;
					break;
				}
			}
		}
	}
}
-(void) cghair:(int)getphoto{
	int tmp = picarray[getphoto].animationRepeatCount;
	tmp = [[dropingname objectAtIndex:tmp] intValue];
	//printf("tmp= %d",tmp);
	int i;
	for (i=0; i<5; i++) {
		if (finalitem[i] == tmp && tmp!=0) {
			finalitemcount--;
			finalitem[i]=0;
			item[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"item%d.png",tmp]];
			printf("item[%d]",i);
			break;
		}
	}
	[self checkcorrect];
}			 
-(void) fall{
	int i;
	if (pausebool) {
		for (i=0; i<6; i++) {
			if (a[i]==1) {
				if (picarray[i].center.y+1+picarray[i].frame.size.height/2>435) {
					picarray[i].image=nil;
					picarray[i].animationRepeatCount = 0;
					a[i]=0;
				}else {
					picarray[i].center = CGPointMake(picarray[i].center.x, picarray[i].center.y+1);
				}
				int hcheck = (hair.center.y-hair.frame.size.height/2)-(picarray[i].center.y+picarray[i].frame.size.height/2);
				int wcheck =  abs(hair.center.x - picarray[i].center.x);
				if (wcheck <= hair.frame.size.width/2 + picarray[i].frame.size.width/3  &&  hcheck<=0 && hcheck>=-25) {
					picarray[i].image = nil;
					a[i]=0;
					[self cghair:i];
				}
			}
		}
	}
}
-(void) checkcorrect{
	if (finalitemcount==0 && finalcolorcount==0) {
		if ([rightmusic checksound]) {
			[rightmusic changevolume:[rightmusic getvolume:1]];
			[rightmusic playmusic];
		}
		Pausebutton.hidden = YES;
		style++;
		pausebool=NO;
		pausepage.hidden=NO;
		[cake stopAnimating];
		[Animation setAnimationImage:pausepage : @"check_pass":@"png" :1 :2];
		[Animation setAndplay:pausepage :1 :2];
		//pic_path = [NSString stringWithString:@"check_pass.png"];
		[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(winpageani) userInfo:nil repeats:NO];
	}
}
//O O
-(void) winpageani{
	if (style>4) {
		[self countscore:1500];
		//acount score
		Score_Show = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Score_Show:) userInfo:nil repeats:YES];
	}else {
		[self countscore:10];
		[self resetflag];
		[self Resume];
		[self setstyle:style];
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	if(pausebool){
		// get touch event
		UITouch *touch = [[event allTouches] anyObject];
		// get the touch location
		CGPoint touchLocation = [touch locationInView:touch.view];
		// move the image view
		if (touchLocation.x - hair.frame.size.width/2<0) {
			touchLocation = CGPointMake(hair.frame.size.width/2, touchLocation.y);
		}else if(touchLocation.x + hair.frame.size.width/2 > 320){
			touchLocation = CGPointMake(320-hair.frame.size.width/2, touchLocation.y);
		}
		touchLocation = CGPointMake(touchLocation.x, hair.center.y);
		hair.center = touchLocation;
		touchLocation = CGPointMake(touchLocation.x, duma.center.y);
		duma.center = touchLocation;
		item0.center = CGPointMake(touchLocation.x+distancex[0], item0.center.y);
		item1.center = CGPointMake(touchLocation.x+distancex[1], item1.center.y);
		item2.center = CGPointMake(touchLocation.x+distancex[2], item2.center.y);
		item3.center = CGPointMake(touchLocation.x+distancex[3], item3.center.y);
		item4.center = CGPointMake(touchLocation.x+distancex[4], item4.center.y);
	}
}
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
	[item0 release];
	[item1 release];
	[item2 release];
	[item3 release];
	[item4 release];
	[pic01 release];
	[pic02 release];
	[pic03 release];
	[pic04 release];
	[pic05 release];
	[pic06 release];
	[duma release];
	[hair release];
	[tips release];
	[cane release];
	[line release];
	[coloritem release];
	[cake release];
	[dropingphoto release];
	[dropingname release];
	[Pausebutton release];
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
	[Score_Show release];
	[Score_Continue release];
	[pic_path release];
	[Score_Frame release];
	[Frame release];
	[rightmusic release];
	playmusic=nil;
	dropitem=nil;
	dropcolor=nil;
	time=nil;
    [super dealloc];
}
#pragma mark -
- (void)accelerometer:(UIAccelerometer *)accelerometer 
        didAccelerate:(UIAcceleration *)acceleration {
	//printf("%lf\n",acceleration.x*20);
	if(pausebool){
		if (acceleration.x*20>10) {
			NSString *tmp = [NSString stringWithFormat:@"lv_4_duma_move_0002.png"];
			duma.image = [UIImage imageNamed:tmp];
			dumapace=1;
		}else if (acceleration.x*20<-10) {
			NSString *tmp = [NSString stringWithFormat:@"lv_4_duma_move_0003.png"];
			duma.image = [UIImage imageNamed:tmp];
			dumapace=1;
		}else{
			NSString *tmp = [NSString stringWithFormat:@"lv_4_duma_move_01_slow000%d.png",dumapace];
			duma.image = [UIImage imageNamed:tmp];
			dumapace++;
			if (dumapace==8) {
				dumapace=1;
			}
		}

		CGPoint touchLocation = CGPointMake(hair.center.x + acceleration.x*20, hair.center.y);
		if (touchLocation.x - hair.frame.size.width/2 <0) {
			touchLocation = CGPointMake(hair.frame.size.width/2, touchLocation.y);
		}else if(touchLocation.x + hair.frame.size.width/2 > 320){
			touchLocation = CGPointMake(320-hair.frame.size.width/2, touchLocation.y);
		}
		hair.center = CGPointMake(touchLocation.x, touchLocation.y);
		duma.center = CGPointMake(touchLocation.x, duma.center.y);
		item0.center = CGPointMake(touchLocation.x+distancex[0], item0.center.y);
		item1.center = CGPointMake(touchLocation.x+distancex[1], item1.center.y);
		item2.center = CGPointMake(touchLocation.x+distancex[2], item2.center.y);
		item3.center = CGPointMake(touchLocation.x+distancex[3], item3.center.y);
		item4.center = CGPointMake(touchLocation.x+distancex[4], item4.center.y);
	}
}
-(IBAction)back{
	int i;
	[playmusic stopmusic];
	[playmusic release];
	if ([dropitem isValid]) {
		[dropitem invalidate];
		dropitem=nil;
	}
	if ([pictimer isValid]) {
		[pictimer invalidate];
		pictimer=nil;
	}
	if ([dropcolor isValid]) {
		[dropcolor invalidate];
		dropcolor = nil;
	}
	if ([colortimer isValid]) {
		[colortimer invalidate];
		colortimer = nil;
	}
	if (time!=nil) {
		[time invalidate];
		time=nil;
	}
	for (i=0; i<7; i++) {
		picarray[i].image=nil;
		a[i]=0;
	}
	NSArray *array = self.navigationController.viewControllers;
	ChooseLevel *tmp = [array objectAtIndex:[array count]-2];
	[tmp reloadlevel];
	[tmp.frame startAnimating];
	[super back];
}
-(IBAction) Pause{
	//[playmusic stopmusic];
	pausepage.image=[UIImage imageNamed:@"pause_bg.png"];
	pausepage.hidden=NO;
	resumebutton.hidden=NO;
	backbutton.hidden=NO;
	pausebool=NO;
}
-(IBAction) Resume{
	if (!pausebool) {
		Pausebutton.hidden=NO;
		/*if([playmusic checksound]){
			[playmusic playmusic];
		}*/
		pausepage.image=nil;
		pausebool=YES;
		resumebutton.hidden=YES;
		backbutton.hidden=YES;
	}
}
-(IBAction) Continue{
	NSLog(@"Fuck");
	if (Score_Show != nil && [Score_Show isValid]) {
		[Score_Show invalidate];
		Score_Show = nil;
	} 
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
	if([pic_path isEqualToString:@"check_timeout.png"]||style>4) {
		[self back];
	}
	pic_path = nil;	
	Pausebutton.hidden = YES;		
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

@end
