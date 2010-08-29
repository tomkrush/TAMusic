//
//  RootController.h
//  Overture
//
//  Created by Tom Krush on 8/28/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAToolkit.h"
#import "TAMusic.h"

@interface RootController : TAViewController 
{
	TAMusicView *_musicView;
}

@property (nonatomic, readonly) TAMusicView *musicView;

@end
