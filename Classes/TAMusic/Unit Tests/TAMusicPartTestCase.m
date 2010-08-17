//
//  TAMusicParTestCase.m
//  TAMusic
//
//  Created by Tom Krush on 8/14/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicPartTestCase.h"
#import "TAMusic.h"

@implementation TAMusicPartTestCase

- (void)testInit
{
	TAMusicPart *part = [[TAMusicPart alloc] init];
	part.name = @"Bb Trumpet";
	part.instrumentName = @"Bb Trumpet";
	
	TAMusicMeasure *measure1 = [[TAMusicMeasure alloc] init];
	[part addMeasure:measure1];
	[measure1 release];
	
	STAssertNotNil(part, @"Part should not be nil");
	
	STAssertEqualObjects(part.name, @"Bb Trumpet", @"Name should be Bb Trumpet");
	STAssertEqualObjects(part.instrumentName, @"Bb Trumpet", @"Name should be Bb Trumpet");

	STAssertNotNil(part.measures, @"Should have measures");
	STAssertEquals([part numberOfMeasures], (NSUInteger)1, @"Part should have 1 measures.");
	STAssertNotNil([part measureAtIndex:0], @"Measure should exist");
	
	[part release];
}

@end
