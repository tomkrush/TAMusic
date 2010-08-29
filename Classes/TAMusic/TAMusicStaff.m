//
//  TAMusicStaff.m
//  Overture
//
//  Created by Tom Krush on 8/27/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicStaff.h"

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
	
	for (NSUInteger i = 0; i < [self.measures count]; i++) 
	{
		TAMusicMeasure *measure = [self.measures objectAtIndex:i];
		
		TAMusicMeasureOptions options = [measure optionsAtIndexInStaff:i];
		
		CGFloat width = [measure width:options] + _extraSpace;
	
		rect.size.width = width;
			
		CGContextSetAllowsAntialiasing(context, NO);
		CGContextSetLineCap(context, kCGLineCapRound);
		CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:222/255 green:198/255 blue:137/255 alpha:0.2f].CGColor);
		CGContextStrokeRect(context, rect);
		
		CGFloat interval = _frame.size.height / 4;
		CGFloat y = interval;
		
		for ( NSUInteger l = 0; l < 3; l++ )
		{
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + y);
			CGContextAddLineToPoint(context, rect.origin.x + width, rect.origin.y + y);
			CGContextStrokePath(context);
			
			y += interval;
		}
		
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
