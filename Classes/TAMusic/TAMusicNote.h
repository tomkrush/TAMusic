//
//  TAMusicNote.h
//  Overture
//
//  Created by Tom Krush on 8/30/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMusicCommon.h"

enum
{
   TAMusicNoteTypeLonga,
   TAMusicNoteTypeBreve,
   TAMusicNoteTypeWhole,
   TAMusicNoteTypeHalf,
   TAMusicNoteTypeQuarter,
   TAMusicNoteTypeEighth,
   TAMusicNoteType16th,
   TAMusicNoteType32nd,
   TAMusicNoteType64th,
   TAMusicNoteType128th,
   TAMusicNoteTypeUnknown,
};
typedef NSUInteger TAMusicNoteType;

@interface TAMusicNote : NSObject 
{
	BOOL _chord;
	NSUInteger _duration;
	TAMusicPitch _pitch;
	TAMusicNoteType _type;
	BOOL _rest;
}

@property (nonatomic) NSUInteger duration;
@property (nonatomic) TAMusicPitch pitch;
@property (nonatomic) TAMusicNoteType type;
@property (nonatomic) BOOL rest;
@property (nonatomic) BOOL chord;

@property (nonatomic, readonly) NSString *restGlyph;
@property (nonatomic, readonly) NSString *noteHeadGlyph;

+ (NSString *)restGlyphForNoteType:(TAMusicNoteType)type;
+ (NSString *)noteHeadGlyphForNoteType:(TAMusicNoteType)type;


@end
