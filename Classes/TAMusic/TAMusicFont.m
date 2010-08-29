//
//  TAMusicFont.m
//  Overture
//
//  Created by Tom Krush on 8/28/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicFont.h"


@implementation TAMusicFont

+ (NSString *)characterForSymbol:(TAMusicGlyph)symbol
{	
	char *bytes;
	
	switch (symbol) 
	{
		case TAMusicGlyphSopranoClef:
			bytes = "\xEF\x81\x82";
		break;

		case TAMusicGlyphTrebleClefUp:
			bytes = "\xEF\x82\xA0";
		break;

		case TAMusicGlyphTrebleClefDown:
			bytes = "\xEF\x81\x96";
		break;

		case TAMusicGlyphTrebleClef:
			bytes = "\xEF\x80\xA6";
		break;

		case TAMusicGlyphAltoClef:
			bytes = "\xEF\x81\x82";
		break;

		case TAMusicGlyphBassClefUp:
			bytes = "\xEF\x83\xA6";
		break;

		case TAMusicGlyphBassClefDown:
			bytes = "\xEF\x81\xB4";
		break;

		case TAMusicGlyphBassClef:
			bytes = "\xEF\x80\xBF";
		break;
		
		case TAMusicGlyphZero:
			bytes = "\xEF\x80\xB0";
		break;
		
		case TAMusicGlyphOne:
			bytes = "\xEF\x80\xB1";
		break;
		
		case TAMusicGlyphTwo:
			bytes = "\xEF\x80\xB2";
		break;
		
		case TAMusicGlyphThree:
			bytes = "\xEF\x80\xB3";
		break;
		
		case TAMusicGlyphFour:
			bytes = "\xEF\x80\xB4";
		break;
		
		case TAMusicGlyphFive:
			bytes = "\xEF\x80\xB5";
		break;
		
		case TAMusicGlyphSize:
			bytes = "\xEF\x80\xB6";
		break;
		
		case TAMusicGlyphSeven:
			bytes = "\xEF\x80\xB7";
		break;
		
		case TAMusicGlyphEight:
			bytes = "\xEF\x80\xB8";
		break;
		
		case TAMusicGlyphNine:
			bytes = "\xEF\x80\xB9";
		break;

		case TAMusicGlyphNone:
			bytes = "";
		break;
	}
	
	size_t length = (sizeof bytes) - 1;
	
	NSData *data = [NSData dataWithBytes:bytes length:length];	

	NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

			
	return [string autorelease];
}

+ (CGSize)sizeOfSymbol:(TAMusicGlyph)symbol
{
	NSString *glyph = [TAMusicFont characterForSymbol:symbol];

	return [glyph sizeWithFont:[UIFont fontWithName:@"Maestro" size:38.0f]];
}

@end
