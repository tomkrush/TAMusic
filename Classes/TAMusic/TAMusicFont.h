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
	
	TAMusicGlyphNone
};
typedef NSUInteger TAMusicGlyph;

@interface TAMusicFont : NSObject 
{

}

+ (NSString *)characterForSymbol:(TAMusicGlyph)symbol;

+ (NSString *)characterForNumber:(NSInteger)number;

+ (CGSize)sizeOfSymbol:(TAMusicGlyph)symbol;

+ (CGSize)sizeOfString:(NSString *)string;

+ (CGSize)sizeOfNumber:(NSUInteger)number;


@end
