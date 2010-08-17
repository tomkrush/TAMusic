//
//  TAMusicMeasure.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicMeasure.h"


@implementation TAMusicMeasure

@synthesize notes = _notes;
@synthesize timeSignature = _timeSignature;
@synthesize keySignature = _keySignature;

- (void)dealloc
{
	[_notes release];
	[super dealloc];
}

@end
