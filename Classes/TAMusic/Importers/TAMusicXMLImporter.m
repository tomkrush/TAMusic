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

		TAMusicPart *part = [self.score partWithUID:UID];

		if ( UID && ! part )
		{
			TAMusicPart *part = [[TAMusicPart alloc] init];
			part.UID = UID;
			
			_part = part;

			[self.score addPart:part];
			[part release];
		}
		else
		{
			_part = part;
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
	else if ( [elementName isEqualToString:@"note"] )
	{
		[self clearBuffer];	

		if ( _note )
		{
			[_measure addNote:_note];
			[_note release];
		}
	
		_note = [[TAMusicNote alloc] init];
	}
	else if ( [elementName isEqualToString:@"pitch"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"duration"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"type"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"octave"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"alter"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"step"] )
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
		else if ( [[self buffer] isEqualToString:@"G"] )
		{
			_clef.sign = TAMusicClefSignG;
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
			_clef.sign = TAMusicClefUnknown;
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
	else if ( [elementName isEqualToString:@"note"] )
	{
		// Add Note to measure
		[self clearBuffer];	

		if ( _note )
		{
			[_measure addNote:_note];
			[_note release];
			_note = nil;
		}
	}
	else if ( [elementName isEqualToString:@"pitch"] )
	{
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"octave"] )
	{
		TAMusicPitch pitch = _note.pitch;
		pitch.octave = [[self buffer] intValue];
	
		_note.pitch = pitch;
		
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"duration"] )
	{
		_note.duration = [[self buffer] intValue];
		
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"alter"] )
	{
		TAMusicPitch pitch = _note.pitch;
		pitch.alter = [[self buffer] intValue];
	
		_note.pitch = pitch;
				
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"rest"] )
	{
		_note.rest = TRUE;
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"chord"] )
	{
		_note.chord = TRUE;
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"type"] )
	{
		if ( [[self buffer] isEqualToString:@"longa"] )
		{
			_note.type = TAMusicNoteTypeLonga;
		}
		else if ( [[self buffer] isEqualToString:@"breve"] )
		{
			_note.type = TAMusicNoteTypeBreve;
		}
		else if ( [[self buffer] isEqualToString:@"whole"] )
		{
			_note.type = TAMusicNoteTypeWhole;
		}
		else if ( [[self buffer] isEqualToString:@"half"] )
		{
			_note.type = TAMusicNoteTypeHalf;
		}
		else if ( [[self buffer] isEqualToString:@"quarter"] )
		{
			_note.type = TAMusicNoteTypeQuarter;
		}
		else if ( [[self buffer] isEqualToString:@"eighth"] )
		{
			_note.type = TAMusicNoteTypeEighth;
		}
		else if ( [[self buffer] isEqualToString:@"16th"] )
		{
			_note.type = TAMusicNoteType16th;
		}
		else if ( [[self buffer] isEqualToString:@"32nd"] )
		{
			_note.type = TAMusicNoteType32nd;
		}
		else if ( [[self buffer] isEqualToString:@"64th"] )
		{
			_note.type = TAMusicNoteType64th;
		}
		else if ( [[self buffer] isEqualToString:@"128th"] )
		{
			_note.type = TAMusicNoteType128th;
		}
						
		[self clearBuffer];
	}
	else if ( [elementName isEqualToString:@"step"] )
	{
		TAMusicPitch pitch = _note.pitch;
		pitch.octave = [[self buffer] intValue];
	
		if ( [[self buffer] isEqualToString:@"C"] )
		{
			pitch.step = TAMusicStepC;
		}
		else if ( [[self buffer] isEqualToString:@"G"] )
		{
			pitch.step = TAMusicStepG;
		}
		else if ( [[self buffer] isEqualToString:@"D"] )
		{
			pitch.step = TAMusicStepD;
		}
		else if ( [[self buffer] isEqualToString:@"A"] )
		{
			pitch.step = TAMusicStepA;
		}
		else if ( [[self buffer] isEqualToString:@"E"] )
		{
			pitch.step = TAMusicStepE;
		}		
		else if ( [[self buffer] isEqualToString:@"B"] )
		{
			pitch.step = TAMusicStepB;
		}
		else if ( [[self buffer] isEqualToString:@"F"] )
		{
			pitch.step = TAMusicStepF;
		}		
		
		_note.pitch = pitch;
		
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
		_buffer = [[_buffer stringByAppendingString:string] retain];
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

- (void)dealloc
{
	[_buffer release];
//	[_part release];
//	[_note release];
//	[_measure release];

	[super dealloc];
}

@end
