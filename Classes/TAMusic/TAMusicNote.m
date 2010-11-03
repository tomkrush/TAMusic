//
//  TAMusicNote.m
//  Overture
//
//  Created by Tom Krush on 8/30/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicNote.h"
#import "TAMusicFont.h"

@implementation TAMusicNote

@synthesize pitch = _pitch;
@synthesize duration = _duration;
@synthesize type = _type;
@synthesize rest = _rest;
@synthesize chord = _chord;

- (id)init
{
	if ( self = [super init] )
	{
		self.type = TAMusicNoteTypeUnknown;
	}
	
	return self;
}

- (NSString *)restGlyph
{
	if ( self.rest )
	{
		return [TAMusicNote restGlyphForNoteType:self.type];
	}

	return nil;
}

- (NSString *)noteHeadGlyph
{
	if ( self.rest == NO)
	{
		return [TAMusicNote noteHeadGlyphForNoteType:self.type];
	}

	return nil;
}

+ (NSString *)noteHeadGlyphForNoteType:(TAMusicNoteType)type
{
	NSString *glyph;

	switch (type) 
	{
		case TAMusicNoteTypeBreve:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHeadBreve];
			break;
		case TAMusicNoteTypeLonga:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHeadLonga];
			break;
		case TAMusicNoteTypeWhole:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHeadWhole];
			break;
		case TAMusicNoteTypeHalf:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHeadHalf];
			break;
		case TAMusicNoteTypeQuarter:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHeadQuarter];
			break;
		case TAMusicNoteTypeEighth:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHeadEighth];
			break;
		case TAMusicNoteType16th:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHead16th];
			break;
		case TAMusicNoteType32nd:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHead32nd];
			break;
		case TAMusicNoteType64th:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHead64th];
			break;
		case TAMusicNoteType128th:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHead128th];
			break;
		case TAMusicNoteTypeUnknown:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNoteHeadQuarter];
			break;
	}
	
	return glyph;
}

+ (NSString *)restGlyphForNoteType:(TAMusicNoteType)type
{
	NSString *glyph;
	
	switch (type) 
	{
		case TAMusicNoteTypeBreve:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRestDefault];
			break;
		case TAMusicNoteTypeLonga:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRestDoubleWhole];
			break;
		case TAMusicNoteTypeWhole:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRestWhole];
			break;
		case TAMusicNoteTypeHalf:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRestHalf];
			break;
		case TAMusicNoteTypeQuarter:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRestQuarter];
			break;
		case TAMusicNoteTypeEighth:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRestEighth];
			break;
		case TAMusicNoteType16th:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRest16th];
			break;
		case TAMusicNoteType32nd:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRest32nd];
			break;
		case TAMusicNoteType64th:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRest64th];
			break;
		case TAMusicNoteType128th:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRest128th];
			break;
		case TAMusicNoteTypeUnknown:
			glyph = [TAMusicFont characterForGlyph:TAMusicGlyphRestDefault];
			break;
	}
	
	return glyph;
}

@end
