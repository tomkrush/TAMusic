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

BOOL TATimeSignatureIsNull(TATimeSignature timeSignature)
{
	if (isnan(timeSignature.beatCount) || isnan(timeSignature.beatDuration) )
	{
		return TRUE;
	}
	
	return FALSE;
}

TAKeySignature TAKeySignatureMake(NSInteger fifth, TAMusicMode mode)
{
	TAKeySignature keySignature;
	keySignature.fifth = fifth;
	keySignature.mode = mode;
	
	return keySignature;
}


BOOL TAKeySignatureIsNull(TAKeySignature keySignature)
{
	// NSLog(@"mode: %d", timeSignature.mode);

	if ( isnan(keySignature.fifth) || isnan(keySignature.mode) )
	{
		return TRUE;
	}
	
	return FALSE;
}