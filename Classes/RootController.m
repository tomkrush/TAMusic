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

@synthesize files = _files;

- (void)viewDidLoad
{
	[self.view addSubview:self.musicView];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:@"Change Score" forState:UIControlStateNormal];
	[button sizeToFit];
	
	[button addTarget:self action:@selector(showScores:) forControlEvents:UIControlEventTouchDown];
	button.origin = CGPointMake(10, 10);
	
	[self.view addSubview:button];
}

- (void)showScores:(UIButton *)button
{
	if ( ! self.files )
	{
		NSError *error = nil;
		
		NSString *path = [[NSBundle mainBundle] bundlePath];
		path = [path stringByAppendingPathComponent:@"musicXML.bundle"];
		
		self.files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
	}
			
	if ( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone )
	{
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.scoreTableViewController];
		self.scoreTableViewController.title = @"Scores";
		
		UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
		self.scoreTableViewController.navigationItem.rightBarButtonItem = button;
		[button release];
		
		[self presentModalViewController:navController animated:YES];
		
		[navController release];
	}
	else
	{
		if ( ! self.scorePopoverController.popoverVisible )
		{
			[self.scorePopoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];	
		}
		else
		{
			[self.scorePopoverController dismissPopoverAnimated:YES];
		}
	}
}

- (void)close
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation
{
	[self.musicView setNeedsDisplay];
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *fileName = [self.files objectAtIndex:indexPath.row];

	[[NSUserDefaults standardUserDefaults] setObject:fileName forKey:@"fileName"];

	NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"musicXML.bundle"];
	NSString *path = [[NSBundle bundleWithPath:bundlePath] pathForResource:fileName ofType:nil];		
				
	TAMusicXMLImporter *importer = [[TAMusicXMLImporter alloc] initWithContentsOfFile:path];
	
	self.musicView.score = importer.score;
	[self.musicView setNeedsDisplay];
	
	[importer release];
	
	if ( self.modalViewController )
	{
		[self dismissModalViewControllerAnimated:YES];
	}
	else
	{
		[self.scorePopoverController dismissPopoverAnimated:YES];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	NSString *cellIdentifier = @"Cell";;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
    if (cell == nil) 
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
	}
		
	cell.textLabel.text = [self.files objectAtIndex:indexPath.row];
		
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.files count];
}

- (UIPopoverController *)scorePopoverController
{
	if ( ! _scorePopoverController )
	{
		_scorePopoverController = [[UIPopoverController alloc] initWithContentViewController:self.scoreTableViewController];
	}
	
	return _scorePopoverController;
}

- (UITableViewController *)scoreTableViewController
{
	if ( ! _scoreTableViewController )
	{
		_scoreTableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
		_scoreTableViewController.tableView.dataSource = self;
		_scoreTableViewController.tableView.delegate = self;
	}

	return _scoreTableViewController;
}

- (TAMusicView *)musicView
{
	if ( ! _musicView )
	{
		NSString *fileName = [[NSUserDefaults standardUserDefaults] objectForKey:@"fileName"];
		
		if ( ! fileName )
		{
			fileName = @"01a-Pitches-Pitches.xml";
		}

		NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"musicXML.bundle"];
		NSString *path = [[NSBundle bundleWithPath:bundlePath] pathForResource:fileName ofType:nil];		
				
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
	[_scorePopoverController release];
	[_files release];
	[_musicView release];
	[_scoreTableViewController release];
	[super dealloc];
}

@end
