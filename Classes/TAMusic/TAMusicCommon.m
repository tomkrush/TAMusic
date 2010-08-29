//
//  TAMusicCommon.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicCommon.h"
#import "TAMusicFont.h"

TATimeSignature TATimeSignatureMake(NSUInteger beatCount, NSUInteger beatDuration)
{
	TATimeSignature timeSignature;
	timeSignature.beatCount = beatCount;
	timeSignature.beatDuration = beatDuration;
	timeSignature.symbol = TAMusicSymbolNone;
	
	return timeSignature;
}

CGSize TAMusicTimeSignatureSize(TATimeSignature timeSignature)
{
	TAMusicSymbol symbol = timeSignature.symbol;

	CGSize size;

	if ( symbol == TAMusicSymbolNone )
	{		
		CGSize beatCount = [TAMusicFont sizeOfNumber:timeSignature.beatCount];
		CGSize beatDuration = [TAMusicFont sizeOfNumber:timeSignature.beatDuration];	

		size.width = beatCount.width >= beatDuration.width ? beatCount.width: beatDuration.width;
		size.height = beatCount.height + beatDuration.height;
	}
	else
	{
		TAMusicGlyph glyph = symbol == TAMusicSymbolCut ? TAMusicGlyphCutTime : TAMusicGlyphCommonTime;
		
		size = [TAMusicFont sizeOfGlyph:glyph];
	}
	
	return size;
}

void TATimeSignatureLog(TATimeSignature timeSignature)
{
	NSString *symbol = @"None";
	
	if ( timeSignature.symbol == TAMusicSymbolCommon )
	{
		symbol = @"Common";
	}
	else if ( timeSignature.symbol == TAMusicSymbolCut )
	{
		symbol = @"Cut";
	}
	
	NSLog(@"Time Signature:{beatCount:%d, beatDuration:%d, symbol:%@}", timeSignature.beatCount, timeSignature.beatDuration, symbol);
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