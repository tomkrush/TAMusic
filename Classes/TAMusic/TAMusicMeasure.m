//
//  TAMusicMeasure.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicMeasure.h"
#import "TAToolkit.h"

#import "TAMusicStaff.h"
#import "TAMusicFont.h"

const CGFloat TAMusicSpaceBeforeClef = 6;
const CGFloat TAMusicSpaceAfterClef = 0;

// Needs to be adjusted for score / parts
const CGFloat TAMusicSpaceBeforeTimeSignature = 6;
const CGFloat TAMusicSpaceAfterTimeSignature = 3;

BOOL TAMusicMeasureHasOption(TAMusicMeasureOptions options, TAMusicMeasureOptions option)
{
	return (options & option) != 0;
}



@implementation TAMusicMeasure

@synthesize number = _number;
@synthesize notes = _notes;
@synthesize timeSignature = _timeSignature;
@synthesize keySignature = _keySignature;
@synthesize clef = _clef;

- (CGFloat)width:(TAMusicMeasureOptions)options
{
//	if ( _width == 0 )
//	{
//		_width = 
//
//	}
	
	CGFloat width = 0;
		
	if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsClef) )
	{
		// Add width of clef
		CGSize size = [TAMusicFont sizeOfGlyph:TAMusicGlyphTrebleClef];
				
		width += TAMusicSpaceBeforeClef + size.width + TAMusicSpaceAfterClef;
	}

	if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsTimeSignature) )
	{
		CGSize size = TAMusicTimeSignatureSize(self.timeSignature);
		
		// Add width of clef
		width += TAMusicSpaceBeforeTimeSignature + size.width + TAMusicSpaceAfterTimeSignature;
	}
	
	if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsKeySignature) )
	{
		// Add width of clef
		width += 22;
	}
	
	if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsNotes) )
	{
		// Add width of clef
		width += 120;
	}
		
	return width; 
}

- (TAMusicMeasureOptions)optionsAtIndexInStaff:(NSUInteger)index previousMeasure:(TAMusicMeasure *)measure
{
	TAMusicMeasureOptions options = TAMusicMeasureOptionsNotes;
	
	if ( index == 0 || ! TAMusicClefIsEqualToClef(self.clef, measure.clef) )
	{
		options |= TAMusicMeasureOptionsClef;
	}

	if ( index == 0 )
	{
		options |= TAMusicMeasureOptionsKeySignature;
	}
	
	if ( self.number == 1  || ! TAMusicTimeSignatureIsEqualToTimeSignature(self.timeSignature, measure.timeSignature) )
	{
		options |= TAMusicMeasureOptionsTimeSignature;
	}	

	return options;
}

- (CGFloat)width
{
	TAMusicMeasureOptions options = TAMusicMeasureOptionsTimeSignature | 
									TAMusicMeasureOptionsKeySignature | 
									TAMusicMeasureOptionsClef | 
									TAMusicMeasureOptionsNotes | 
									TAMusicMeasureOptionsLyrics;

	return [self width:options];
}

- (void)dealloc
{
	[_notes release];
	[super dealloc];
}

@end
