//
//  TAMusicMeasureLayer.m
//  Overture
//
//  Created by Tom Krush on 8/17/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicStaffLayer.h"

@implementation TAMusicStaffLayer

@synthesize measures = _measures;


- (void)dealloc
{
	[_measures release];

	[super dealloc];
}

@end
