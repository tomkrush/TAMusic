//
//  TAMusicFont.m
//  Overture
//
//  Created by Tom Krush on 8/28/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicFont.h"


@implementation TAMusicFont

+ (NSString *)characterForGlyph:(TAMusicGlyph)symbol
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

		case TAMusicGlyphUnknownClef:
			bytes = "\xEF\x83\x96";
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

		case TAMusicGlyphPercussionClef:
			bytes = "\xEF\x82\x8B";
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
		
		case TAMusicGlyphSix:
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
		
		case TAMusicGlyphCutTime:
			bytes = "\xEF\x81\x83";
		break;
		
		case TAMusicGlyphCommonTime:
			bytes = "\xEF\x81\xA3";
		break;

		case TAMusicGlyphPlus:
			bytes = "\xEF\x80\xAB";
		break;
		
		case TAMusicGlyphMinus:
			bytes = "\xEF\x80\xAD";
		break;		

		case TAMusicGlyphNatural:
			bytes = "\xEF\x81\xAE";
		break;
		
		case TAMusicGlyphFlat:
			bytes = "\xEF\x81\xA2";
		break;
		
		case TAMusicGlyphSharp:
			bytes = "\xEF\x80\xA3";
		break;		

		case TAMusicGlyphDoubleFlat:
			bytes = "\xEF\x82\xBA";
		break;	

		case TAMusicGlyphDoubleSharp:
			bytes = "\xEF\x83\x9C";
		break;	

		case TAMusicGlyphNoteHeadLonga:
			bytes = "\xEF\x82\x87";
		break;

		case TAMusicGlyphNoteHeadBreve:
			bytes = "\xEF\x82\x87";
		break;

		case TAMusicGlyphNoteHeadWhole:
			bytes = "\xEF\x81\xB7";
		break;

		case TAMusicGlyphNoteHeadHalf:
			bytes = "\xEF\x83\xBA";
		break;

		case TAMusicGlyphNoteHeadQuarter:
			bytes = "\xEF\x83\x8F";
		break;

		case TAMusicGlyphNoteHeadEighth:
			bytes = "\xEF\x83\x8F";
		break;

		case TAMusicGlyphNoteHead16th:
			bytes = "\xEF\x83\x8F";
		break;

		case TAMusicGlyphNoteHead32nd:
			bytes = "\xEF\x83\x8F";
		break;

		case TAMusicGlyphNoteHead64th:
			bytes = "\xEF\x83\x8F";
		break;

		case TAMusicGlyphNoteHead128th:
			bytes = "\xEF\x83\x8F";
		break;

		case TAMusicGlyphRestDoubleWhole:
			bytes = "\xEF\x83\x90";
		break;

		case TAMusicGlyphRestWhole:
			bytes = "\xEF\x82\xB7";
		break;

		case TAMusicGlyphRestHalf:
			bytes = "\xEF\x83\xAE";
		break;

		case TAMusicGlyphRestQuarter:
			bytes = "\xEF\x83\x8E";
		break;

		case TAMusicGlyphRestEighth:
			bytes = "\xEF\x83\xA4";
		break;

		case TAMusicGlyphRest16th:
			bytes = "\xEF\x83\x85";
		break;

		case TAMusicGlyphRest32nd:
			bytes = "\xEF\x82\xA8";
		break;

		case TAMusicGlyphRest64th:
			bytes = "\xEF\x83\xB4";
		break;

		case TAMusicGlyphRest128th:
			bytes = "\xEF\x83\xA5";
		break;

		case TAMusicGlyphRestDefault:
			bytes = "\xEF\x82\xB7";
		break;

		case TAMusicAugmentationDot:
			bytes = "\xEF\x80\xAE";
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

+ (NSString *)characterForNumber:(NSInteger)number
{
	NSString *numberString = [NSString stringWithFormat:@"%d", number];

	NSString *result = @"";

	for ( NSUInteger i = 0; i < [numberString length]; i++ )
	{
		number = [[numberString substringWithRange:NSMakeRange(i, 1)] intValue];
		
		TAMusicGlyph glyph = TAMusicGlyphNone;

		if ( number == 0 )
		{
			glyph = TAMusicGlyphZero;
		}
		else if ( number == 1 )
		{
			glyph = TAMusicGlyphOne;
		}
		else if ( number == 2 )
		{
			glyph = TAMusicGlyphTwo;
		}
		else if ( number == 3 )
		{
			glyph = TAMusicGlyphThree;
		}
		else if ( number == 4 )
		{
			glyph = TAMusicGlyphFour;
		}	
		else if ( number == 5 )
		{
			glyph = TAMusicGlyphFive;
		}
		else if ( number == 6 )
		{
			glyph = TAMusicGlyphSix;
		}
		else if ( number == 7 )
		{
			glyph = TAMusicGlyphSeven;
		}
		else if ( number == 8 )
		{
			glyph = TAMusicGlyphEight;
		}
		else if ( number == 9 )
		{
			glyph = TAMusicGlyphNine;
		}
		
		result = [result stringByAppendingString:[TAMusicFont characterForGlyph:glyph]];
	}
					
	return result;
}

+ (CGSize)sizeOfGlyph:(TAMusicGlyph)symbol
{
	NSString *glyph = [TAMusicFont characterForGlyph:symbol];

	return [TAMusicFont sizeOfString:glyph];
}

+ (CGSize)sizeOfNumber:(NSUInteger)number
{
	NSString *glyph = [TAMusicFont characterForNumber:number];

	return [TAMusicFont sizeOfString:glyph];
}

+ (CGSize)sizeOfString:(NSString *)string
{
	return [string sizeWithFont:[UIFont fontWithName:@"Maestro" size:44.0f]];
}

@end
