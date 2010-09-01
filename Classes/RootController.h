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

@interface RootController : TAViewController <UITableViewDataSource, UITableViewDelegate>
{
	TAMusicView *_musicView;
	
	UITableViewController *_scoreTableViewController;
	UIPopoverController *_scorePopoverController;

	UITableViewController *_partsTableViewController;
	
	NSArray *_files;
	
	UIButton *_part;
	
	UILabel *_scoreTitle;
}

- (void)setScoreTitle:(NSString *)title;

@property (nonatomic, retain) NSArray *files;
@property (nonatomic, readonly) TAMusicView *musicView;

@property (nonatomic, readonly) UILabel *scoreTitle;

@property (nonatomic, readonly) UIPopoverController *scorePopoverController;

@property (nonatomic, readonly) UITableViewController *scoreTableViewController;
@property (nonatomic, readonly) UITableViewController *partsTableViewController;

@end
