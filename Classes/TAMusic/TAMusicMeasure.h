//
//  TAMusicMeasure.h
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMusicCommon.h"

@class TAMusicStaff;

enum
{
   TAMusicMeasureOptionsTimeSignature	= 0,
   TAMusicMeasureOptionsKeySignature	= 1 << 0,
   TAMusicMeasureOptionsClef			= 1 << 1,
   TAMusicMeasureOptionsNotes			= 1 << 2,
   TAMusicMeasureOptionsLyrics			= 1 << 3,
   TAMusicMeasureOptionsNone			= 1 << 4
};
typedef NSUInteger TAMusicMeasureOptions;

BOOL TAMusicMeasureHasOption(TAMusicMeasureOptions options, TAMusicMeasureOptions option);

@interface TAMusicMeasure : NSObject 
{
	NSArray *_notes;
	TATimeSignature _timeSignature;
	TAKeySignature _keySignature;
	TAMusicClef	_clef;
	
	NSUInteger _number;
	
	CGFloat _width;
}

@property (nonatomic, retain) NSArray *notes;
@property (nonatomic) TATimeSignature timeSignature;
@property (nonatomic) TAKeySignature keySignature;
@property (nonatomic) TAMusicClef clef;
@property (nonatomic) NSUInteger number;

@property (nonatomic, readonly) CGFloat width;

- (CGFloat)width:(TAMusicMeasureOptions)options;

- (TAMusicMeasureOptions)optionsAtIndexInStaff:(NSUInteger)index;

@end
