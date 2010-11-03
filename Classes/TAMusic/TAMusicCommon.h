//
//  TAMusicCommon.h
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Pitch

enum
{
   TAMusicStepA,
   TAMusicStepB,
   TAMusicStepC,
   TAMusicStepD,
   TAMusicStepE,
   TAMusicStepF,
   TAMusicStepG
};
typedef NSUInteger TAMusicStep;

struct TAMusicPitch 
{
   TAMusicStep step;
   NSInteger alter;
   NSInteger octave;
};
typedef struct TAMusicPitch TAMusicPitch;

TAMusicPitch TAMusicPitchMake(TAMusicStep step, NSUInteger alter, NSInteger octave);
TAMusicPitch TAMusicPitchDefault();
void TAMusicPitchLog(TAMusicPitch pitch);

#pragma mark -
#pragma mark Clef

enum 
{
   TAMusicClefSignC,
   TAMusicClefSignF,
   TAMusicClefSignG,
   TAMusicClefSignPercussion,
   TAMusicClefUnknown
};
typedef NSUInteger TAMusicClefSign;

struct TAMusicClef 
{
   TAMusicClefSign sign;
   NSInteger line;
};
typedef struct TAMusicClef TAMusicClef;

TAMusicClef TAMusicClefMake(TAMusicClefSign sign, NSInteger line);
TAMusicClef TAMusicClefDefault();
void TAMusicClefLog(TAMusicClef clef);
CGFloat TAMusicDifferenceInStep(TAMusicClef clef, TAMusicPitch pitch);
CGFloat TAMusicVerticalPosition(TAMusicClef clef, TAMusicPitch pitch);
TAMusicPitch TAMusicPitchForClef(TAMusicClef clef);

BOOL TAMusicClefIsEqualToClef(TAMusicClef sign1, TAMusicClef sign2);

#pragma mark -
#pragma mark Time Signature

enum
{
   TAMusicSymbolCommon,
   TAMusicSymbolCut,
   TAMusicSymbolNone
};
typedef NSUInteger TAMusicSymbol;

struct TATimeSignature 
{
   NSUInteger beatCount;
   NSUInteger beatDuration;
   TAMusicSymbol symbol;
};
typedef struct TATimeSignature TATimeSignature;

void TATimeSignatureLog(TATimeSignature timeSignature);
TATimeSignature TATimeSignatureMake(NSUInteger beatCount, NSUInteger beatDuration);
BOOL TAMusicTimeSignatureIsEqualToTimeSignature(TATimeSignature timeSignature1, TATimeSignature timeSignature2);

TATimeSignature TATimeSignatureDefault();

CGSize TAMusicTimeSignatureSize(TATimeSignature timeSignature);

#pragma mark -
#pragma mark Key Signature

const CGFloat TAMusicSpaceBetweenKeySignatureAccidentals;

enum 
{
   TAMusicModeMajor,
   TAMusicModeMinor
};
typedef NSUInteger TAMusicMode;

struct TAKeySignature 
{
   NSInteger fifth;
   TAMusicMode mode;
};
typedef struct TAKeySignature TAKeySignature;

CGSize TAMusicKeySignatureSize(TAKeySignature keySignature);
TAKeySignature TAKeySignatureMake(NSInteger fifth, TAMusicMode mode);
BOOL TAMusicKeySignatureIsEqualToKeySignature(TAKeySignature keySignature1, TAKeySignature keySignature2);
TAKeySignature TAKeySignatureDefault();
