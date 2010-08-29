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

TATimeSignature TATimeSignatureMake(NSUInteger beatCount, NSUInteger beatDuration);

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

enum 
{
   TAMusicClefSignC,
   TAMusicClefSignF,
   TAMusicClefSignG
};
typedef NSUInteger TAMusicClefSign;

struct TAMusicClef 
{
   TAMusicClefSign sign;
   NSInteger line;
};
typedef struct TAMusicClef TAMusicClef;

TAMusicClef TAMusicClefMake(TAMusicClefSign sign, NSInteger line);
