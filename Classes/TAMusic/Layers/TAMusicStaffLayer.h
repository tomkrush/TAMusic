//
//  TAMusicMeasureLayer.h
//  Overture
//
//  Created by Tom Krush on 8/17/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface TAMusicStaffLayer : CALayer
{
	NSArray *_measures;
}

@property (nonatomic, retain) NSArray *measures;

@end
