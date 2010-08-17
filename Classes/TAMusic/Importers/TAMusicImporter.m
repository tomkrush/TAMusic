//
//  TAMusicImporter.m
//  Overture
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicImporter.h"

@implementation TAMusicImporter


- (TAMusicScore *)score
{
	if ( ! _score )
	{
		_score = [[TAMusicScore alloc] init];
	}
	
	return _score;
}

- (void)dealloc
{
	[_score release];
	
	[super dealloc];
}

@end
