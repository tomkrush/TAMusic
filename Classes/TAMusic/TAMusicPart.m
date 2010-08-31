//
//  TAMusicPart.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicPart.h"
#import "TAMusicMeasure.h"

@interface TAMusicPart () 

- (NSMutableArray *)_measures;

@end

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
	return [[self _measures] objectAtIndex:index];
}

- (void)addMeasure:(TAMusicMeasure *)measure
{
	[[self _measures] addObject:measure];
}

- (void)insertPart:(TAMusicMeasure *)measure atIndex:(NSUInteger)index
{
	[[self _measures] insertObject:measure atIndex:index];
}

- (NSMutableArray *)_measures
{
	if ( ! _measures )
	{
		_measures = [[NSMutableArray alloc] init];
	}
	
	return _measures;
}

- (NSArray *)measures
{
	return [[[self _measures] copy] autorelease];
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
