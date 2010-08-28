//
//  TAMusicStaff.h
//  Overture
//
//  Created by Tom Krush on 8/27/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMusicPart.h"
#import "TAMusicMeasure.h"

@interface TAMusicStaff : NSObject 
{
	NSArray *_measures;
	TAMusicPart *_part;
	
	CGFloat _width;
}

- (id)initWithPart:(TAMusicPart *)part width:(CGFloat)width;
- (void)drawInContext:(CGContextRef)context;

@property (nonatomic, readonly) NSArray *measures;
@property (nonatomic) CGFloat width;
@property (nonatomic, readonly) TAMusicPart *part;
@property (nonatomic, readonly) CGFloat measureWidth;

@end
