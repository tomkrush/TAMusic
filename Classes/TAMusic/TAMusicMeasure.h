//
//  TAMusicMeasure.h
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMusicCommon.h"

#import <CoreText/CoreText.h>

const CGFloat TAMusicSpaceBeforeClef;
const CGFloat TAMusicSpaceAfterClef;

// Needs to be adjusted for score / parts
const CGFloat TAMusicSpaceBeforeTimeSignature;
const CGFloat TAMusicSpaceAfterTimeSignature;

CGSize TAMusicTimeSignatureSize(TATimeSignature timeSignature);

@class TAMusicStaff;

enum
{
   TAMusicMeasureOptionsTimeSignature	= 1 << 0,
   TAMusicMeasureOptionsKeySignature	= 1 << 1,
   TAMusicMeasureOptionsClef			= 1 << 2,
   TAMusicMeasureOptionsNotes			= 1 << 3,
   TAMusicMeasureOptionsLyrics			= 1 << 4,
   TAMusicMeasureOptionsNone			= 1 << 5
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

- (TAMusicMeasureOptions)optionsAtIndexInStaff:(NSUInteger)index previousMeasure:(TAMusicMeasure *)measure;

@end
