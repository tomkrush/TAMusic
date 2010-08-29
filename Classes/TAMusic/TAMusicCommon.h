//
//  TAMusicCommon.h
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

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

CGSize TAMusicTimeSignatureSize(TATimeSignature timeSignature);

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

TAKeySignature TAKeySignatureMake(NSInteger fifth, TAMusicMode mode);
BOOL TAMusicKeySignatureIsEqualToKeySignature(TAKeySignature keySignature1, TAKeySignature keySignature2);

enum 
{
   TAMusicClefSignC,
   TAMusicClefSignF,
   TAMusicClefSignG,
   TAMusicClefSignPercussion
};
typedef NSUInteger TAMusicClefSign;

struct TAMusicClef 
{
   TAMusicClefSign sign;
   NSInteger line;
};
typedef struct TAMusicClef TAMusicClef;

TAMusicClef TAMusicClefMake(TAMusicClefSign sign, NSInteger line);

BOOL TAMusicClefIsEqualToClef(TAMusicClef sign1, TAMusicClef sign2);
