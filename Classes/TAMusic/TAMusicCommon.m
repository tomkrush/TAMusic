//
//  TAMusicCommon.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicCommon.h"

TAKeySignature TAKeySignatureMake(NSUInteger beatCount, NSUInteger beatDuration)
{
	TAKeySignature keySignature;
	keySignature.beatCount = beatCount;
	keySignature.beatDuration = beatDuration;
	
	return keySignature;
}

TATimeSignature TATimeSignatureMake(NSInteger fifth, TAMusicMode mode)
{
	TATimeSignature timeSignature;
	timeSignature.fifth = fifth;
	timeSignature.mode = mode;
	
	return timeSignature;
}