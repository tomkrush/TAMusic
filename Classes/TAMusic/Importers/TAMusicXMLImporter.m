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

			_clef = TAMusicClefDefault();
			_timeSignature = TATimeSignatureDefault();
			_keySignature = TAKeySignatureDefault();

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
	else if ( [elementName isEqualToString:@"fifths"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"mode"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"time"] )
	{
		[self clearBuffer];

		NSString *symbol = [attributeDict valueForKey:@"symbol"];
		
		if ( symbol )
		{
			if ( [symbol isEqualToString:@"common"] )
			{
				_timeSignature.symbol = TAMusicSymbolCommon;
			}
			else if ( [symbol isEqualToString:@"cut"] )
			{
				_timeSignature.symbol = TAMusicSymbolCut;
			}
		}
		else
		{
			_timeSignature.symbol = TAMusicSymbolNone;
		}
	}
	else if ( [elementName isEqualToString:@"beats"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"beat-type"] )
	{		
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"measure"] )
	{
		[self clearBuffer];	

		if ( _measure )
		{
			[_part addMeasure:_measure];
			[_measure release];
		}
				
		_measure = [[TAMusicMeasure alloc] init];

		NSString *number = [attributeDict valueForKey:@"number"];

		if ( number )
		{
			_measure.number = [number intValue];
		}
	}
	else if ( [elementName isEqualToString:@"line"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"sign"] )
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
	else if ( [elementName isEqualToString:@"fifths"] )
	{
		_keySignature.fifth = [[self buffer] intValue];
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"mode"] )
	{		
		_keySignature.mode = [[self buffer] isEqualToString:@"minor"] ? TAMusicModeMinor : TAMusicModeMajor;
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"beats"] )
	{
		_timeSignature.beatDuration = [[self buffer] intValue];
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"beat-type"] )
	{		
		_timeSignature.beatCount = [[self buffer] intValue];
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"line"] )
	{
		_clef.line = [[self buffer] intValue];
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"sign"] )
	{
		if ( [[self buffer] isEqualToString:@"C"] )
		{
			_clef.sign = TAMusicClefSignC;
		}
		else if ( [[self buffer] isEqualToString:@"F"] )
		{
			_clef.sign = TAMusicClefSignF;
		}
		else if ( [[self buffer] isEqualToString:@"percussion"] )
		{
			_clef.sign = TAMusicClefSignPercussion;
		}
		else
		{
			_clef.sign = TAMusicClefSignG;
		}
	
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"measure"] )
	{
		// Fix Time Signature (Cut Time)
		if ( _timeSignature.beatCount == 2 && _timeSignature.beatDuration == 2 && _timeSignature.symbol == TAMusicSymbolCommon )
		{
			_timeSignature.symbol = TAMusicSymbolCut;
		}
				
		// Assign parts to measure
		_measure.keySignature = _keySignature;
		_measure.timeSignature = _timeSignature;
		_measure.clef = _clef;
		
		if ( _measure )
		{
			[_part addMeasure:_measure];
			[_measure release];
			_measure = nil;
		}
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
