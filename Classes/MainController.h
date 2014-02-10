//
//  MainController.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/3/5.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseLevel.h"
#import "Practice.h"
#import "Free.h"
#import "Option.h"
#import "BackPage.h"
#define levelfile @"level.plist"

@interface MainController : BackPage {
	ChooseLevel *levelpage;
	Practice *practicepage;
	Free *freepage;
	Option *optionpage;
	IBOutlet UIImageView *mainpage;
	IBOutlet UIImageView *fram;
	IBOutlet UIButton *chooselevelbutton;
	IBOutlet UIButton *practicebutton;
	IBOutlet UIButton *fullbutton;
	IBOutlet UIButton *optionbutton;
}
@property (nonatomic, retain) UIImageView *mainpage;
@property (nonatomic, retain) UIImageView *fram;
@property (nonatomic, retain) ChooseLevel *levelpage;
@property (nonatomic, retain) Practice *practicepage;
@property (nonatomic, retain) Free *freepage;
@property (nonatomic, retain) Option *optionpage;
@property (nonatomic, retain) UIButton *chooselevelbutton, *fullbutton, *practicebutton, *optionbutton;

-(void) reload;
-(IBAction) pressplay;
-(IBAction) presspractice;
-(IBAction) pressfull;
-(IBAction) pressoption;
-(NSString *) datafilepath;

@end
