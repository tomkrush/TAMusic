//
//  TAMusicView.m
//  Overture
//
//  Created by Tom Krush on 8/27/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicView.h"


@implementation TAMusicView

- (id)initWithScore:(TAMusicScore *)score
{
	if ( self = [super init] )
	{
		_score = score;
		[_score retain];
	}
	
	return self;
}

- (void)drawRect:(CGRect)rect
{
	[[UIColor whiteColor] set];
	UIRectFill(rect);

	CGContextRef context = UIGraphicsGetCurrentContext();
	
	TAMusicPart *part = [_score.parts objectAtIndex:0];
	NSUInteger numberOfMeasures = [part numberOfMeasures];
	
	CFRange measureRange = CFRangeMake(0, numberOfMeasures);
	
	CGFloat height = 32;
	height = 44;
	
	CGRect staffFrame = CGRectMake(50, 70, rect.size.width, height);
			
	while (measureRange.length > 0) 
	{			
		TAMusicStaff *staff = [[TAMusicStaff alloc] initWithPart:part frame:staffFrame inRange:measureRange];
				
		measureRange.location = staff.measureRange.location + staff.measureRange.length;
		measureRange.length = numberOfMeasures - measureRange.location;

		[staff drawInContext:context];
		
		[staff release];
		
		staffFrame.origin.y += 50 + staffFrame.size.height;
	}
}

- (void)dealloc
{
	[_score release];
	[super dealloc];
}

@end
