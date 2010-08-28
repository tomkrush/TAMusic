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
	
	TAMusicStaff *staff = [[TAMusicStaff alloc] initWithPart:part width:self.frame.size.width];

	[staff drawInContext:context];
	
	[staff release];

//	NSString *string = @" ";
//		
//	const char bytes[] = "\xEF\x80\xBD";
//	size_t length = (sizeof bytes) - 1;
//	
//	NSData *data = [NSData dataWithBytes:bytes length:length];
//	
//	string = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
//	NSLog(@"%@", string);
//
//
//	
//	
//	[[UIColor blackColor] set];
//
//	UIFont *font = [UIFont fontWithName:@"Maestro" size:48];
//	[string drawInRect:CGRectMake(40, 40, 400, 400) withFont:font];
}

- (void)dealloc
{
	[_score release];
	[super dealloc];
}

@end
