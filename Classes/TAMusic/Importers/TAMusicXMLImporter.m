//
//  TAMusicXMLProcessor.m
//  Overture
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "TAMusicXMLImporter.h"

@interface TAMusicXMLImporter ()

- (void)appendToBuffer:(NSString *)string;
- (void)clearBuffer;
- (NSString *)buffer;

@end


@implementation TAMusicXMLImporter

- (id)initWithContentsOfFile:(NSString *)path
{
	if ( path )
	{
		NSError *error;
		
		NSData *data = [NSData dataWithContentsOfFile:path options:0 error:&error];
		
		return [self initWithData:data];
	}
	
	return nil;
}

- (id)initWithContentsOfURL:(NSURL *)url
{
	if ( url )
	{
		NSError *error;
		
		NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];

		return [self initWithData:data];
	}
	
	return nil;
}

- (id)initWithData:(NSData *)data
{
	if ( data )
	{
		if ( [super init] )
		{	
			NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
			[parser setDelegate:self];

			[parser parse];

			[parser release];
		}
		
		return self;
	}
	
	return nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	if ( [elementName isEqualToString:@"part"] || [elementName isEqualToString:@"score-part"] )
	{		
		NSString *UID = [attributeDict valueForKey:@"id"];

		if ( UID && ! [self.score partWithUID:UID] )
		{
			TAMusicPart *part = [[TAMusicPart alloc] init];
			part.UID = UID;
			
			_part = part;

			[self.score addPart:part];
			[part release];
		}
	}
	else if ( [elementName isEqualToString:@"part-name"] )
	{
		[self clearBuffer];	
	}

	_element = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{	
	if ( [elementName isEqualToString:@"movement-title"] )
	{
		self.score.title = [[self buffer] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		[self clearBuffer];	
	}
	else if ( [elementName isEqualToString:@"part-name"] )
	{
		if ( _part )
		{
			_part.name = [self buffer];
		}
		
		[self clearBuffer];	
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[self appendToBuffer:string];
}

- (void)appendToBuffer:(NSString *)string
{
	if ( ! _buffer )
	{
		_buffer = string;
		[_buffer retain];
	}
	else
	{
		NSString *tempBuffer = [[NSString alloc] initWithFormat:@"%@%@", _buffer, string];
		
		[_buffer release];
		_buffer = tempBuffer;
		[_buffer retain];
		
		[tempBuffer release];
	}
}

- (void)clearBuffer
{
	_buffer = nil;
}

- (NSString *)buffer
{
	return _buffer;
}

@end
