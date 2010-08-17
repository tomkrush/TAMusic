//
//  MusicTestCase.m
//  TAMusic
//
//  Created by Tom Krush on 8/14/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicScoreTestCase.h"
#import "TAMusic.h"

@implementation TAMusicScoreTestCase

- (void)testInit
{
	TAMusicScore *score = [[TAMusicScore alloc] init];
	score.title = @"Pitches and accidentals";
	
	STAssertNotNil(score, @"Score should not be nil");
	
	STAssertEquals([score numberOfMeasures], (NSUInteger)0, @"Score should have 4 measures");
	
	STAssertEqualObjects(score.title, @"Pitches and accidentals", @"Score title is incorrect");
	
	[score release];
}

- (void)testParts
{
	TAMusicScore *score = [[TAMusicScore alloc] init];
	
	TAMusicPart *part1 = [[TAMusicPart alloc] init];
	part1.UID = @"P1";
	
	TAMusicPart *part2 = [[TAMusicPart alloc] init];
	part2.UID = @"P2";
	
	[score addPart:part1];
	[score insertPart:part2 atIndex:0];
	
	STAssertNotNil([score parts], @"Part should not be nil");
	
	STAssertEquals([score numberOfParts], 2u, @"Score should have 2 parts");

	STAssertNotNil([score partAtIndex:0], @"Part should not be nil");

	STAssertNotNil([score partWithUID:@"P1"], @"Part 1 should not be nil");
	STAssertEqualObjects([score partWithUID:@"P1"].UID, @"P1", @"Part 1 should been returned");
	STAssertNotNil([score partWithUID:@"P2"], @"Part 2 should not be nil");
	STAssertEqualObjects([score partWithUID:@"P2"].UID, @"P2", @"Part 2 should been returned");

	[score release];
}

@end
