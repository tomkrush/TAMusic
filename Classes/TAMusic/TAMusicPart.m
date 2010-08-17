//
//  TAMusicPart.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicPart.h"
#import "TAMusicMeasure.h"

@implementation TAMusicPart

@synthesize name = _name;
@synthesize instrumentName = _instrumentName;
@synthesize measures = _measures;
@synthesize UID = _UID;

- (NSUInteger)numberOfMeasures
{
	return [self.measures count];
}

- (TAMusicMeasure *)measureAtIndex:(NSUInteger)index
{
	return nil;
}

- (void)dealloc
{
	[_UID release];
	[_name release];
	[_instrumentName release];
	[_measures release];

	[super dealloc];
}

@end
