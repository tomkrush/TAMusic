//
//  RootController.m
//  Overture
//
//  Created by Tom Krush on 8/28/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "RootController.h"

@implementation RootController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.view addSubview:self.musicView];
}

- (TAMusicView *)musicView
{
	if ( ! _musicView )
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"01a-Pitches-Pitches" ofType:@"xml"];
		
		TAMusicXMLImporter *importer = [[TAMusicXMLImporter alloc] initWithContentsOfFile:path];
		
		TAMusicScore *score = importer.score;
		
		NSLog(@"%@", score.title);
		NSLog(@"Number of Parts: %d", [score numberOfParts]);
		NSLog(@"Parts %@", [score.parts valueForKey:@"name"]);

		_musicView = [[TAMusicView alloc] initWithScore:importer.score];	
		_musicView.frame = self.view.frame;
		_musicView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

		[importer release];	
	}

	return _musicView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void)dealloc
{
	[_musicView release];
	[super dealloc];
}

@end
