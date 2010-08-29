//
//  TAMusicXMLProcessor.h
//  Overture
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMusicImporter.h"
#import "TAMusicPart.h"
#import "TAMusicMeasure.h"

typedef NSUInteger TAMusicXMLElementKey;


typedef NSUInteger TAMusicXMLElement;

@interface TAMusicXMLImporter : TAMusicImporter
{
	NSString *_element;
	NSString *_buffer;
	
	TAMusicPart *_part;
	TATimeSignature _timeSignature;
	TAKeySignature _keySignature;
	TAMusicClef _clef;
	TAMusicMeasure *_measure;
}

- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;
- (id)initWithData:(NSData *)data;

@end
