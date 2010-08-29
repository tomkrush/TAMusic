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
				
				TAMusicMeasureOptions options = [measure optionsAtIndexInStaff:index];
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

	
	for (NSUInteger i = 0; i < [self.measures count]; i++) 
	{
		TAMusicMeasure *measure = [self.measures objectAtIndex:i];
		
		TAMusicMeasureOptions options = [measure optionsAtIndexInStaff:i];
		
		CGFloat width = [measure width:options] + _extraSpace;
	
		rect.size.width = width;
		
		CGContextSaveGState(context);
		CGContextSetAllowsAntialiasing(context, YES);

//		if ( i == 0 )
//		{
			CGRect clefRect = rect;

			TAMusicGlyph glyph;

			switch (measure.clef.sign) 
			{
				case TAMusicClefSignG:
					glyph = TAMusicGlyphTrebleClef;
					break;
				case TAMusicClefSignF:
					glyph = TAMusicGlyphBassClef;
					break;
				case TAMusicClefSignC:
					glyph = TAMusicGlyphAltoClef;
					break;
			}
						
			NSUInteger line = measure.clef.line;
						
			clefRect.origin.y -= (interval * (line)) + interval - 3.5;

			NSString *string = [TAMusicFont characterForSymbol:glyph];

			UIFont *font = [UIFont fontWithName:@"Maestro" size:self.frame.size.height];

			[[UIColor colorWithWhite:0.0f alpha:0.75f] set];
			[[UIColor blackColor] set];

			[string drawInRect:clefRect withFont:font];
//		}
		
		CGContextRestoreGState(context);

			
		CGContextSaveGState(context);
		CGContextSetAllowsAntialiasing(context, NO);
		CGContextSetLineCap(context, kCGLineCapRound);
		CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:222/255 green:198/255 blue:137/255 alpha:0.2f].CGColor);
		CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f].CGColor);
		CGContextStrokeRect(context, rect);
		
		CGFloat y = interval;
				
		for ( NSUInteger l = 0; l < 3; l++ )
		{
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + y);
			CGContextAddLineToPoint(context, rect.origin.x + width, rect.origin.y + y);
			CGContextStrokePath(context);
			
			y += interval;
		}

		CGContextRestoreGState(context);
		
		rect.origin.x += width;
		
	}
}

- (void)dealloc
{
	[_measures release];
	[_part release];
	[super dealloc];
}

@end
