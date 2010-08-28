//
//  TAMusicMeasure.h
//  TAMusic
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMusicCommon.h"

@interface TAMusicMeasure : NSObject 
{
	NSArray *_notes;
	TATimeSignature _timeSignature;
	TAKeySignature _keySignature;
}

@property (nonatomic, retain) NSArray *notes;
@property (nonatomic) TATimeSignature timeSignature;
@property (nonatomic) TAKeySignature keySignature;



@end
