//
//  TAMusicImporter.h
//  Overture
//
//  Created by Tom Krush on 8/15/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMusicScore.h"

@interface TAMusicImporter : NSObject 
{
	TAMusicScore *_score;
}

@property (nonatomic, readonly) TAMusicScore *score;

@end
