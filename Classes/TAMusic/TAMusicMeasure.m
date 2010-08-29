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
		CGSize size = [TAMusicFont sizeOfSymbol:TAMusicGlyphTrebleClef];
				
		width += size.width;
	}
	
	if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsTimeSignature) )
	{
		// Add width of clef
		width += 22;
	}

	if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsKeySignature) )
	{
		// Add width of clef
		width += 22;
	}
	
	if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsNotes) )
	{
		// Add width of clef
		width += 72;
	}
		
	return width; 
}

- (TAMusicMeasureOptions)optionsAtIndexInStaff:(NSUInteger)index
{
	TAMusicMeasureOptions options = TAMusicMeasureOptionsNotes;
	
	//if ( index == 0 )
	//{
		options |= TAMusicMeasureOptionsClef | TAMusicMeasureOptionsKeySignature;
	//}
	
	if ( self.number == 1 )
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
