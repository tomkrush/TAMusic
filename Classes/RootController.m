//
//  RootController.m
//  Overture
//
//  Created by Tom Krush on 8/28/10.
//  Copyright 2010 Tweakie Apps. All rights reserved.
//

#import "RootController.h"
#import "TAToolkit.h"

@implementation RootController

- (void)viewDidLoad
{
	[self.view addSubview:self.musicView];
}

- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation
{
	[self.musicView setNeedsDisplay];
}

- (TAMusicView *)musicView
{
	if ( ! _musicView )
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"01a-Pitches-Pitches" ofType:@"xml"];
		
		TAMusicXMLImporter *importer = [[TAMusicXMLImporter alloc] initWithContentsOfFile:path];

		_musicView = [[TAMusicView alloc] initWithScore:importer.score];	
		_musicView.frame = self.view.bounds;
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
