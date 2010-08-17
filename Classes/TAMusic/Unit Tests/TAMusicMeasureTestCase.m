//
//  TAMusicMeasureTestCase.m
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicMeasureTestCase.h"
#import "TAMusic.h"

@implementation TAMusicMeasureTestCase

- (void)testInit
{
	TAMusicMeasure *measure = [[TAMusicMeasure alloc] init];
	measure.timeSignature = TATimeSignatureMake(4, 4);
	measure.keySignature = TAKeySignatureMake(1, TAMusicModeMajor);
	measure.notes = [NSArray array];
	
	STAssertNotNil(measure, @"Measure should not be nil");
	STAssertNotNil(measure.notes, @"Measure should have notes");
	
	[measure release];
}

@end
