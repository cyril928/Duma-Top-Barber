//
//  PMusic.m
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/11.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import "PMusic.h"


@implementation PMusic
@synthesize filetoplay;
-(void) setinfinloop{
	avplayer.numberOfLoops = -1;
}
- (id)initWithFileName:(NSString *) filename {
	[super init];
	filetoplay = [[NSString alloc] initWithString:filename];
	NSString *fileString;
	fileString = [[NSBundle mainBundle] pathForResource:filetoplay ofType:@"wav"];
	avplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fileString] error:NULL];
	return self;
}
-(void) playmusic{
	[avplayer play];
}
-(void) stopmusic{
	[avplayer stop];
	avplayer.currentTime=0;
}
-(void) changevolume:(float)vl{
	avplayer.volume = vl;
}
-(float) getvolume:(int)num{
	NSString *filepath = [self datafilepath];
	float tmp = 0;
	if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
		tmp = [[array objectAtIndex:num+2] floatValue];
		[array release];
	}
	return tmp;
}
-(void) vibrate{
	AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}
-(NSString*) datafilepath{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docum = [path objectAtIndex:0];
	return [docum stringByAppendingPathComponent:switchfile];
}
-(BOOL) checksound{
	NSString *filepath = [self datafilepath];
	BOOL tmp = YES;
	if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
		tmp = [[array objectAtIndex:0] boolValue];
		[array release];
	}
	return tmp;
}
-(BOOL) checkvib{
	NSString *filepath = [self datafilepath];
	BOOL tmp = YES;
	if([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filepath];
		tmp = [[array objectAtIndex:1] boolValue];
		[array release];
	}
	return tmp;
}

- (void)dealloc {
	[avplayer stop];
	if (avplayer != nil) {
		[avplayer release];
	}
	[filetoplay release];
    [super dealloc];
}

@end
