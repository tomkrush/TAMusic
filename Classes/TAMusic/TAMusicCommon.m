//
//  TAMusicCommon.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicCommon.h"

TATimeSignature TATimeSignatureMake(NSUInteger beatCount, NSUInteger beatDuration)
{
	TATimeSignature timeSignature;
	timeSignature.beatCount = beatCount;
	timeSignature.beatDuration = beatDuration;
	timeSignature.symbol = TAMusicSymbolNone;
	
	return timeSignature;
}

TAKeySignature TAKeySignatureMake(NSInteger fifth, TAMusicMode mode)
{
	TAKeySignature keySignature;
	keySignature.fifth = fifth;
	keySignature.mode = mode;
	
	return keySignature;
}

TAMusicClef TAMusicClefMake(TAMusicClefSign sign, NSInteger line)
{
	TAMusicClef clef;
	clef.sign = sign;
	clef.line = line;
	
	return clef;
}