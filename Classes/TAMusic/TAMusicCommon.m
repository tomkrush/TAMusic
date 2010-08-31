//
//  TAMusicCommon.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicCommon.h"
#import "TAMusicFont.h"
#import "TAToolkit.h"

#pragma mark -
#pragma mark Pitch

TAMusicPitch TAMusicPitchMake(TAMusicStep step, NSUInteger alter, NSUInteger octave)
{
	TAMusicPitch pitch;
	pitch.step = step;
	pitch.alter = alter;
	pitch.octave = octave;
	
	return pitch;
}

TAMusicPitch TAMusicPitchDefault()
{
	return TAMusicPitchMake(TAMusicStepC, 0, 2);
}

#pragma mark -
#pragma mark Time Signature

TATimeSignature TATimeSignatureDefault()
{
	return TATimeSignatureMake(4, 4);
}

TATimeSignature TATimeSignatureMake(NSUInteger beatCount, NSUInteger beatDuration)
{
	TATimeSignature timeSignature;
	timeSignature.beatCount = beatCount;
	timeSignature.beatDuration = beatDuration;
	timeSignature.symbol = TAMusicSymbolNone;
	
	return timeSignature;
}

BOOL TAMusicTimeSignatureIsEqualToTimeSignature(TATimeSignature timeSignature1, TATimeSignature timeSignature2)
{
	if ( timeSignature1.beatCount == timeSignature2.beatCount && timeSignature1.beatDuration == timeSignature2.beatDuration && timeSignature1.symbol == timeSignature2.symbol) 
	{
		return YES;
	}
	
	return NO;
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

#pragma mark -
#pragma mark Key Signature

const CGFloat TAMusicSpaceBetweenKeySignatureAccidentals = 0;

CGSize TAMusicKeySignatureSize(TAKeySignature keySignature)
{
	CGSize size;

	NSInteger fifth = keySignature.fifth;
	TAMusicGlyph glyph = TAMusicGlyphNatural;
	TAMusicGlyph doubleGlyph = TAMusicGlyphNatural;
				
	if ( fifth < 0 )
	{
		glyph = TAMusicGlyphFlat;
		doubleGlyph = TAMusicGlyphDoubleFlat;
	}
	else if ( fifth > 0 )
	{
		glyph = TAMusicGlyphSharp;
		doubleGlyph = TAMusicGlyphDoubleSharp;
	}
	
	CGSize glyphSize = [TAMusicFont sizeOfGlyph:glyph];
	CGSize doubleGlyphSize = [TAMusicFont sizeOfGlyph:doubleGlyph];
	
	
	NSInteger absFifth = (CGFloat)abs(fifth);
	
	NSUInteger doubles = absFifth > 7 ? 4 + -(11 - absFifth) : 0;
	NSUInteger singles = doubles > 0 ? 7 - doubles : absFifth;
	
	CGFloat amount = (CGFloat)abs(fifth);
	amount = amount > 7 ? 7 : amount;
	
	size.width = (amount * TAMusicSpaceBetweenKeySignatureAccidentals);
	size.width += glyphSize.width * singles;
	size.width += doubleGlyphSize.width * doubles;
		
	//size.height = glyphSize.height + (0.5f * glyphSize.height * amount);

	return size;
}

TAKeySignature TAKeySignatureMake(NSInteger fifth, TAMusicMode mode)
{
	TAKeySignature keySignature;
	keySignature.fifth = fifth;
	keySignature.mode = mode;
	
	return keySignature;
}

TAKeySignature TAKeySignatureDefault()
{
	return TAKeySignatureMake(0, TAMusicModeMajor);
}

BOOL TAMusicKeySignatureIsEqualToKeySignature(TAKeySignature keySignature1, TAKeySignature keySignature2)
{
	if ( keySignature1.fifth == keySignature2.fifth && keySignature1.mode == keySignature2.mode) 
	{
		return YES;
	}
	
	return NO;
}

#pragma mark -
#pragma mark Clef

TAMusicClef TAMusicClefMake(TAMusicClefSign sign, NSInteger line)
{
	TAMusicClef clef;
	clef.sign = sign;
	clef.line = line;
	
	return clef;
}

TAMusicClef TAMusicClefDefault()
{
	return TAMusicClefMake(TAMusicClefSignG, 2);
}

BOOL TAMusicClefIsEqualToClef(TAMusicClef clef1, TAMusicClef clef2)
{
	if ( clef1.sign == clef2.sign && clef1.line == clef2.line) 
	{
		return YES;
	}
	
	return NO;
}
