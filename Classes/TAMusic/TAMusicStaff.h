//
//  TAMusicStaff.h
//  Overture
//
//  Created by Tom Krush on 8/27/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMusicPart.h"
#import "TAMusicFont.h"
#import "TAMusicMeasure.h"

@interface TAMusicStaff : NSObject 
{
	NSArray *_measures;
	CFRange _measureRange;
	
	CGRect _frame;
	
	TAMusicPart *_part;
	
	CGFloat _extraSpace;
	
	CGFloat _width;
}

- (id)initWithPart:(TAMusicPart *)part frame:(CGRect)frame inRange:(CFRange)inRange;
- (void)drawInContext:(CGContextRef)context;

@property (nonatomic, readonly) NSArray *measures;
@property (nonatomic) CGRect frame;
@property (nonatomic, readonly) TAMusicPart *part;
@property (nonatomic, readonly) CFRange measureRange;

@end
