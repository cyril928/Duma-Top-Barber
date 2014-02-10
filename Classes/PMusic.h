//
//  PMusic.h
//  Meme
//
//  Created by NTU Mobile Lab on 2010/4/11.
//  Copyright 2010 Nation Taiwan University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>
#define switchfile @"soundswitch.plist"

@interface PMusic : NSObject {
	AVAudioPlayer *avplayer;
	NSString *filetoplay;
}
@property (nonatomic, retain) NSString *filetoplay;

-(id) initWithFileName:(NSString *)fileName;

-(NSString *) datafilepath;
-(BOOL) checksound;
-(BOOL) checkvib;
-(float) getvolume:(int) num;
-(void) playmusic;
-(void) stopmusic;
-(void) vibrate;
-(void) changevolume:(float)vl;
-(void) setinfinloop;
@end
