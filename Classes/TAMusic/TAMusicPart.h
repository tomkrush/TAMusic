//
//  TAMusicPart.h
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TAMusicMeasure;

@interface TAMusicPart : NSObject 
{
	NSString *_name;
	NSString *_UID;
	NSString *_instrumentName;
	NSMutableArray *_measures;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *UID;
@property (nonatomic, retain) NSString *instrumentName;
@property (nonatomic, readonly) NSArray *measures;

- (NSUInteger)numberOfMeasures;
- (TAMusicMeasure *)measureAtIndex:(NSUInteger)index;

- (void)addMeasure:(TAMusicMeasure *)measure;
- (void)insertPart:(TAMusicMeasure *)measure atIndex:(NSUInteger)index;

@end
