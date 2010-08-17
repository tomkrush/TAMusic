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

typedef NSUInteger TAMusicXMLElementKey;


typedef NSUInteger TAMusicXMLElement;

@interface TAMusicXMLImporter : TAMusicImporter <NSXMLParserDelegate>
{
	NSString *_element;
	NSString *_buffer;
	
	TAMusicPart *_part;
}

- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;
- (id)initWithData:(NSData *)data;

@end
