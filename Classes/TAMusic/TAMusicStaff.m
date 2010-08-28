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

- (id)initWithPart:(TAMusicPart *)part width:(CGFloat)width
{
	if ( self = [super init]) 
	{
		if ( part == nil )
		{
			return nil;
		}
	
		if ( part.measures )
		{
//			NSRange range;
//			range.location = measureRange.location;
//			range.length = measureRange.length;
//		
			_measures = [part.measures subarrayWithRange:NSMakeRange(0, 4)];

//			_measures = part.measures;
			[_measures retain];
		}
	
		_width = width - 100;
		_part = part;
		[_part retain];
	}
	
	return self;
}

- (CGFloat)width
{
	if ( isnan(_width) )
	{
		return 320;
	}

	return _width;
}

- (void)setWidth:(CGFloat)width
{
	_width = width;
}

- (CGFloat)measureWidth
{
	CGFloat width = self.width / [self.measures count];
	
	// Minimum Width Per Measure
	if ( width < 42 )
	{
		width = 42;
	}
	
	// Maximum Width Per Measure
	if ( width > 450 )
	{
		width = 450;
	}

	
	return width;
}

- (void)drawInContext:(CGContextRef)context
{
	CGFloat height = 32;

	CGRect rect;
	rect.origin = CGPointMake(50, 70);
	rect.size.width = self.measureWidth;
	rect.size.height = height;
	
	for (NSUInteger i = 0; i < [self.measures count]; i++) 
	{
		CGContextSetAllowsAntialiasing(context, NO);
		CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:222/255 green:198/255 blue:137/255 alpha:0.2f].CGColor);
		CGContextStrokeRect(context, rect);
		
		CGFloat interval = height / 4;
		CGFloat y = interval;
		
		for ( NSUInteger l = 0; l < 3; l++ )
		{
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + y);
			CGContextAddLineToPoint(context, rect.origin.x + self.measureWidth, rect.origin.y + y);
			CGContextStrokePath(context);
			
			y += interval;
		}
		
		rect.origin.x += self.measureWidth;
	}
}

- (void)dealloc
{
	[_measures release];
	[_part release];
	[super dealloc];
}

@end
