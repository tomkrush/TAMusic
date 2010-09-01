//
//  TAMusicView.h
//  Overture
//
//  Created by Tom Krush on 8/27/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAMusicScore.h"
#import "TAMusicStaff.h"
#import "TAMusicPart.h"

@interface TAMusicView : UIScrollView 
{
	TAMusicScore *_score;
	TAMusicPart *_part;
}

- (id)initWithScore:(TAMusicScore *)score;

@property (nonatomic, retain) TAMusicPart *part;
@property (nonatomic, retain) TAMusicScore *score;

@end
