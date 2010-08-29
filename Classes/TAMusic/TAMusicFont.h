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
	
	// Numbers
	TAMusicGlyphZero,
	TAMusicGlyphOne,
	TAMusicGlyphTwo,
	TAMusicGlyphThree,
	TAMusicGlyphFour,
	TAMusicGlyphFive,
	TAMusicGlyphSize,
	TAMusicGlyphSeven,
	TAMusicGlyphEight,
	TAMusicGlyphNine,
	
	TAMusicGlyphNone
};
typedef NSUInteger TAMusicGlyph;

@interface TAMusicFont : NSObject 
{

}

+ (NSString *)characterForSymbol:(TAMusicGlyph)symbol;

+ (CGSize)sizeOfSymbol:(TAMusicGlyph)symbol;

@end
