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
   TAMusicModeMajor,
   TAMusicModeMinor
};
typedef NSUInteger TAMusicMode;

struct TAKeySignature 
{
   NSUInteger beatCount;
   NSUInteger beatDuration;
};
typedef struct TAKeySignature TAKeySignature;

TAKeySignature TAKeySignatureMake(NSUInteger beatCount, NSUInteger beatDuration);


struct TATimeSignature 
{
   NSInteger fifth;
   TAMusicMode mode;
};
typedef struct TATimeSignature TATimeSignature;

TATimeSignature TATimeSignatureMake(NSInteger fifth, TAMusicMode mode);