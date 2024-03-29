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

const CGFloat TAMusicSpaceBeforeKeySignature;
const CGFloat TAMusicSpaceAfterKeySignature;

const CGFloat TAMusicSpaceBeforeNotes;
const CGFloat TAMusicSpaceAfterNotes;

const CGFloat TAMusicSpaceBeforeNote;
const CGFloat TAMusicSpaceAfterNote;

CGSize TAMusicTimeSignatureSize(TATimeSignature timeSignature);

@class TAMusicStaff;
@class TAMusicNote;

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
	NSMutableArray *_notes;
	TATimeSignature _timeSignature;
	TAKeySignature _keySignature;
	TAMusicClef	_clef;
	
	NSUInteger _number;
	
	CGFloat _width;
}

@property (nonatomic, readonly) NSArray *notes;
@property (nonatomic) TATimeSignature timeSignature;
@property (nonatomic) TAKeySignature keySignature;
@property (nonatomic) TAMusicClef clef;
@property (nonatomic) NSUInteger number;

@property (nonatomic, readonly) CGFloat width;

- (CGFloat)width:(TAMusicMeasureOptions)options;

- (TAMusicMeasureOptions)optionsAtIndexInStaff:(NSUInteger)index previousMeasure:(TAMusicMeasure *)measure;

- (void)addNote:(TAMusicNote *)note;

@end
