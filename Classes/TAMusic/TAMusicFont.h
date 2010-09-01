//
//  TAMusicFont.h
//  Overture
//
//  Created by Tom Krush on 8/28/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
	// Clefs
	TAMusicGlyphSopranoClef,
	TAMusicGlyphTrebleClefUp,
	TAMusicGlyphTrebleClefDown,
	TAMusicGlyphTrebleClef,
	TAMusicGlyphAltoClef,
	TAMusicGlyphBassClefUp,
	TAMusicGlyphBassClefDown,
	TAMusicGlyphBassClef,
	TAMusicGlyphPercussionClef,
	TAMusicGlyphUnknownClef,
	
	// Numbers
	TAMusicGlyphZero,
	TAMusicGlyphOne,
	TAMusicGlyphTwo,
	TAMusicGlyphThree,
	TAMusicGlyphFour,
	TAMusicGlyphFive,
	TAMusicGlyphSix,
	TAMusicGlyphSeven,
	TAMusicGlyphEight,
	TAMusicGlyphNine,
	
	// Plus + Minus
	TAMusicGlyphPlus,
	TAMusicGlyphMinus,
	
	// Time Signature Symbols,
	TAMusicGlyphCutTime,
	TAMusicGlyphCommonTime,
	
	// Key Signature
	TAMusicGlyphNatural,
	TAMusicGlyphFlat,
	TAMusicGlyphSharp,
	TAMusicGlyphDoubleFlat,
	TAMusicGlyphDoubleSharp,
	
	// Note Heads
	TAMusicGlyphNoteHeadLonga,
	TAMusicGlyphNoteHeadBreve,
	TAMusicGlyphNoteHeadWhole,
	TAMusicGlyphNoteHeadHalf,
	TAMusicGlyphNoteHeadQuarter,
	TAMusicGlyphNoteHeadEighth,
	TAMusicGlyphNoteHead16th,
	TAMusicGlyphNoteHead32nd,
	TAMusicGlyphNoteHead64th,
	TAMusicGlyphNoteHead128th,

	// Rests
	TAMusicGlyphRestDoubleWhole,
	TAMusicGlyphRestWhole,
	TAMusicGlyphRestHalf,
	TAMusicGlyphRestQuarter,
	TAMusicGlyphRestEighth,
	TAMusicGlyphRest16th,
	TAMusicGlyphRest32nd,
	TAMusicGlyphRest64th,
	TAMusicGlyphRest128th,
	TAMusicGlyphRestDefault,
	
	// Augmentation
	TAMusicAugmentationDot,
	
	TAMusicGlyphNone
};
typedef NSUInteger TAMusicGlyph;

@interface TAMusicFont : NSObject 
{

}

+ (NSString *)characterForGlyph:(TAMusicGlyph)symbol;

+ (NSString *)characterForNumber:(NSInteger)number;

+ (CGSize)sizeOfGlyph:(TAMusicGlyph)symbol;

+ (CGSize)sizeOfString:(NSString *)string;

+ (CGSize)sizeOfNumber:(NSUInteger)number;


@end
