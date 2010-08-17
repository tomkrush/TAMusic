//
//  TAMusicScore.h
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TAMusicPart;

@interface TAMusicScore : NSObject 
{
	NSString *_title;
	NSMutableArray *_parts;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, readonly) NSArray *parts;

- (NSUInteger)numberOfParts;
- (NSUInteger)numberOfMeasures;

- (TAMusicPart *)partAtIndex:(NSUInteger)index;
- (TAMusicPart *)partWithUID:(NSString *)ID;


- (void)addPart:(TAMusicPart *)part;
- (void)insertPart:(TAMusicPart *)part atIndex:(NSUInteger)index;

@end
