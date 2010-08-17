//
//  TAMusicScore.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicScore.h"
#import "TAMusicPart.h"

@interface TAMusicScore () 

- (NSMutableArray *)_parts;

@end


@implementation TAMusicScore

@synthesize title = _title;


- (NSUInteger)numberOfParts
{
	return [[self _parts] count];
}

- (NSUInteger)numberOfMeasures
{
	return 0;
}

- (TAMusicPart *)partAtIndex:(NSUInteger)index
{
	return [[self _parts] objectAtIndex:index];
}

- (void)addPart:(TAMusicPart *)part
{
	[[self _parts] addObject:part];
}

- (void)insertPart:(TAMusicPart *)part atIndex:(NSUInteger)index
{
	[[self _parts] insertObject:part atIndex:index];
}

- (TAMusicPart *)partWithUID:(NSString *)UID
{
	NSArray *parts = [[self _parts] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.UID == %@", UID]];
	
	if ( [parts count] )
	{
		return [parts objectAtIndex:0];
	}
	
	return nil;
}

- (NSArray *)parts
{
	if ( _parts )
	{
		return [_parts copy];
	}
	
	return nil;
}

- (NSMutableArray *)_parts
{
	if ( ! _parts )
	{
		_parts = [[NSMutableArray alloc] init];
	}
	
	return _parts;
}

- (void)dealloc
{
	[_parts release];
	[_title release];

	[super dealloc];
}

@end
