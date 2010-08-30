//
//  TAMusicStaff.m
//  Overture
//
//  Created by Tom Krush on 8/27/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicStaff.h"
#import <CoreText/CoreText.h>

@implementation TAMusicStaff

@synthesize measures = _measures;
@synthesize part = _part;

- (id)initWithPart:(TAMusicPart *)part frame:(CGRect)frame inRange:(CFRange)inRange
{
	if ( self = [super init]) 
	{
		if ( part == nil )
		{
			return nil;
		}
		
		_frame = frame;
		_frame.size.width -= 100;
	
		if ( part.measures )
		{
			CGFloat totalWidth = 0;
			NSUInteger totalMeasures = [part.measures count];
			
			NSUInteger location = inRange.location;
			NSUInteger length = 0;
			
			NSUInteger index = 0;
			for (NSUInteger i = inRange.location; i < totalMeasures; i++)
			{
				if ( i >= inRange.location + inRange.length )
				{
					break;
				}
			
				TAMusicMeasure *measure = [part.measures objectAtIndex:i];
				
				TAMusicMeasure *previousMeasure = i > 0 ? [part.measures objectAtIndex:i - 1] : nil;
				
				TAMusicMeasureOptions options = [measure optionsAtIndexInStaff:index previousMeasure:previousMeasure];
				CGFloat measureWidth = [measure width:options];
				
				if ( totalWidth + measureWidth > _frame.size.width )
				{
					break;
				}
							
				totalWidth += measureWidth;
				length++;
				index++;
			}
				
			_extraSpace = (_frame.size.width - totalWidth) / length;
				
			_measureRange = CFRangeMake(location, length);		
							
			_measures = [part.measures subarrayWithRange:NSMakeRange(location, length)];
			[_measures retain];
		}
	
		_part = part;
		[_part retain];
	}
	
	return self;
}

- (CFRange)measureRange
{
	return _measureRange;
}

- (CGRect)frame
{
	return _frame;
}

- (void)setFrame:(CGRect)frame
{
	_frame = frame;
}

- (void)drawInContext:(CGContextRef)context
{
	CGRect rect = _frame;
	CGFloat interval = _frame.size.height / 4;

	CGContextSaveGState(context);
	
	for (NSUInteger i = 0; i < [self.measures count]; i++) 
	{
		CGContextSetAllowsAntialiasing(context, YES);

		TAMusicMeasure *measure = [self.measures objectAtIndex:i];
		
		NSUInteger measureIndex = [self.part.measures indexOfObject:measure];
		
		TAMusicMeasure *previousMeasure = measureIndex > 0 ? [self.part.measures objectAtIndex:measureIndex - 1] : nil;
				
		TAMusicMeasureOptions options = [measure optionsAtIndexInStaff:i previousMeasure:previousMeasure];
		
		CGFloat width = [measure width:options] + _extraSpace;
	
		rect.size.width = width;

		CGFloat x = 0.0f;
		
		UIFont *font = [UIFont fontWithName:@"Maestro" size:self.frame.size.height];

		// Draw Clef
		if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsClef) )
		{
			CGContextSaveGState(context);

			CGRect clefRect = rect;

			TAMusicGlyph glyph;
						
			CGFloat offset = 0;

			NSUInteger line = measure.clef.line;

			switch (measure.clef.sign) 
			{
				case TAMusicClefSignG:
					glyph = TAMusicGlyphTrebleClef;
					break;
				case TAMusicClefSignF:
					glyph = TAMusicGlyphBassClef;
					break;
				case TAMusicClefSignPercussion:
					glyph = TAMusicGlyphPercussionClef;
					offset = -1;
					line = 3;
					break;
				case TAMusicClefSignC:
					glyph = TAMusicGlyphAltoClef;
					break;
			}
	
			clefRect.origin.x += TAMusicSpaceBeforeClef;
			clefRect.origin.y -= (interval * (line + offset)) + interval;

			NSString *string = [TAMusicFont characterForGlyph:glyph];
			CGSize clefSize = [TAMusicFont sizeOfGlyph:glyph];
			clefRect.size.width = clefSize.width;

			[[UIColor colorWithWhite:0.0f alpha:0.75f] set];
			[[UIColor blackColor] set];

			[string drawInRect:clefRect withFont:font];
			
			x += TAMusicSpaceBeforeClef + clefRect.size.width + TAMusicSpaceAfterClef;
	
			CGContextRestoreGState(context);
		}
		
		// Draw Key Signature
		if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsKeySignature) )
		{
			CGContextSaveGState(context);

			NSInteger fifth = measure.keySignature.fifth;
			//TAMusicMode mode = measure.keySignature.mode;

			NSInteger amount = abs(fifth);

			CGSize accidentalSize = TAMusicKeySignatureSize(measure.keySignature);

			CGRect accidentalRect = rect;
			accidentalRect.size.width = accidentalSize.width;
			
			NSString *glyph = [TAMusicFont characterForGlyph:TAMusicGlyphNatural];
			NSString *doubleGlyph = [TAMusicFont characterForGlyph:TAMusicGlyphNatural];

			// Treble Lines
			CGFloat fifths[7];
						
			if ( fifth > 0 )
			{
				fifths[0] = 5.0f;
				fifths[1] = 3.5f;
				fifths[2] = 5.5f;
				fifths[3] = 4.0f;
				fifths[4] = 2.5f;
				fifths[5] = 4.5f;
				fifths[6] = 3.0f;

				glyph = [TAMusicFont characterForGlyph:TAMusicGlyphSharp];
				doubleGlyph = [TAMusicFont characterForGlyph:TAMusicGlyphDoubleSharp];
			}
			else
			{
				fifths[0] = 3.0f;
				fifths[1] = 4.5f;
				fifths[2] = 2.5f;
				fifths[3] = 4.0f;
				fifths[4] = 2.0f;
				fifths[5] = 3.5f;
				fifths[6] = 1.5f;
				
				glyph = [TAMusicFont characterForGlyph:TAMusicGlyphFlat];
				doubleGlyph = [TAMusicFont characterForGlyph:TAMusicGlyphDoubleFlat];
			}
			
			CGSize glyphSize = [TAMusicFont sizeOfString:glyph];
			CGSize doubleGlyphSize = [TAMusicFont sizeOfString:doubleGlyph];
	
			CGFloat offset = 0;
			CGFloat line = 0;

			[[UIColor blackColor] set];

			accidentalRect.origin.x += TAMusicSpaceBeforeKeySignature + x;
			CGFloat accidentalY = accidentalRect.origin.y;	

			for ( NSInteger index = 0; index < 7; index++ )
			{
				if (index >= amount) break;
			
				NSString *drawGlyph = glyph;
				CGSize size = glyphSize;
				
				NSInteger lineIndex = index;
						
				if ( amount > 7 )
				{
					lineIndex = index + (amount - 7);
					
					if ( lineIndex >= 7 )
					{
						lineIndex -= 7;
						
						drawGlyph = doubleGlyph;
						size = doubleGlyphSize;
					}
				}
				//NSLog(@"%f %d", fifths[lineIndex], lineIndex);
				line = fifths[lineIndex];		
				
				accidentalRect.origin.y = accidentalY - ((interval * (line + offset)) + interval);

				[drawGlyph drawInRect:accidentalRect withFont:font];

				accidentalRect.origin.x += size.width + TAMusicSpaceBetweenKeySignatureAccidentals;
			}

			x += TAMusicSpaceBeforeKeySignature + accidentalRect.size.width + TAMusicSpaceAfterKeySignature;

			CGContextRestoreGState(context);
		}

		// Draw Time Signature			
		if ( TAMusicMeasureHasOption(options, TAMusicMeasureOptionsTimeSignature) )
		{
			CGContextSaveGState(context);

			TAMusicSymbol symbol = measure.timeSignature.symbol;
			
			if ( symbol == TAMusicSymbolNone )
			{
				NSString *beatCount = [TAMusicFont characterForNumber:measure.timeSignature.beatCount];
				NSString *beatDuration = [TAMusicFont characterForNumber:measure.timeSignature.beatDuration];		
			
				CGSize beatCountSize = [TAMusicFont sizeOfString:beatCount];
				CGSize beatDurationSize = [TAMusicFont sizeOfString:beatDuration];
			
				CGSize timeSignatureSize = TAMusicTimeSignatureSize(measure.timeSignature);
				
				CGRect timeSignatureRect = rect;
				timeSignatureRect.size = timeSignatureSize;

				[[UIColor blackColor] set];

				// Base
				CGFloat timeSignatureXOrigin = timeSignatureRect.origin.x + TAMusicSpaceBeforeTimeSignature + x;
				
				timeSignatureRect.origin.x = timeSignatureXOrigin + (( timeSignatureSize.width - beatCountSize.width) / 2);
				timeSignatureRect.origin.y -= (interval * 3);

				[beatCount drawInRect:timeSignatureRect withFont:font];	
				
				timeSignatureRect.origin.x = timeSignatureXOrigin + (( timeSignatureSize.width - beatDurationSize.width) / 2);
				timeSignatureRect.origin.y -= (interval * 2);
				[beatDuration drawInRect:timeSignatureRect withFont:font];
				
				x += TAMusicSpaceBeforeTimeSignature + timeSignatureRect.size.width + TAMusicSpaceAfterTimeSignature;
			}
			else
			{
				NSString *string;
			
				if ( symbol == TAMusicSymbolCut )
				{
					string = [TAMusicFont characterForGlyph:TAMusicGlyphCutTime];
				}
				else {
					string = [TAMusicFont characterForGlyph:TAMusicGlyphCommonTime];
				}
		
				[[UIColor blackColor] set];
				
				CGRect timeSignatureRect = rect;
				timeSignatureRect.origin.x += TAMusicSpaceBeforeTimeSignature + x;
				timeSignatureRect.size.width -= (x - timeSignatureRect.origin.x);
				timeSignatureRect.origin.y -= (interval * (3)) + interval;
				
				[string drawInRect:timeSignatureRect withFont:font];
				
				x += TAMusicSpaceBeforeTimeSignature + timeSignatureRect.size.width + TAMusicSpaceAfterTimeSignature;
			}
			
			CGContextRestoreGState(context);
		}

			
		CGContextSaveGState(context);
		CGContextSetAllowsAntialiasing(context, NO);
		CGContextSetLineCap(context, kCGLineCapRound);
		CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:222/255 green:198/255 blue:137/255 alpha:0.4f].CGColor);
		//CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f].CGColor);
		
		// Draw Outer border
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
		CGContextAddLineToPoint(context, rect.origin.x + width, rect.origin.y);
		CGContextAddLineToPoint(context, rect.origin.x + width, rect.origin.y+rect.size.height);
		CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);
		
		CGFloat y = interval;
				
		// Draw Lines
		for ( NSUInteger l = 0; l < 3; l++ )
		{
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + y);
			CGContextAddLineToPoint(context, rect.origin.x + width, rect.origin.y + y);
			
			y += interval;
		}

		CGContextStrokePath(context);


		CGContextRestoreGState(context);
		
		rect.origin.x += width;
	}
	
	CGContextRestoreGState(context);
}

- (void)dealloc
{
	[_measures release];
	[_part release];
	[super dealloc];
}

@end
