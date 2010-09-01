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
	
	
	_part = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	
	[_part addTarget:self action:@selector(showParts:) forControlEvents:UIControlEventTouchDown];
	_part.top = 10;
	_part.left = button.right + 10;
	
	[self.view addSubview:_part];
	

	TAMusicPart *part = [self.musicView.score.parts objectAtIndex:0];
	NSString *name = part.name ? part.name : @"Untitled Part";
	[_part setTitle:part.name forState:UIControlStateNormal];
	[_part sizeToFit];
	
	[self.view addSubview:self.scoreTitle];

	[self setScoreTitle:self.musicView.score.title];
	self.scoreTitle.centerX = self.view.width / 2;
}

- (void)setScoreTitle:(NSString *)title
{
	title = title ? title : @"Untited Score";

	self.scoreTitle.top = 17;
	self.scoreTitle.text = title;
	[self.scoreTitle sizeToFit];
}

- (void)showParts:(UIButton *)button
{
	if ( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone )
	{
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.partsTableViewController];
		self.partsTableViewController.title = @"Parts";
		
		UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
		self.partsTableViewController.navigationItem.rightBarButtonItem = button;
		[button release];
		
		[self presentModalViewController:navController animated:YES];
		
		[navController release];
	}
	else
	{
		if ( ! self.scorePopoverController.popoverVisible )
		{
			[self.scorePopoverController setContentViewController:self.partsTableViewController];
			[self.scorePopoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];	
		}
		else
		{
			[self.scorePopoverController dismissPopoverAnimated:YES];
		}
	}
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
			[self.scorePopoverController setContentViewController:self.scoreTableViewController];

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
	if ( [tableView isEqual:self.scoreTableViewController.tableView] )
	{
		NSString *fileName = [self.files objectAtIndex:indexPath.row];

		[[NSUserDefaults standardUserDefaults] setObject:fileName forKey:@"fileName"];

		NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"musicXML.bundle"];
		NSString *path = [[NSBundle bundleWithPath:bundlePath] pathForResource:fileName ofType:nil];		
					
		TAMusicXMLImporter *importer = [[TAMusicXMLImporter alloc] initWithContentsOfFile:path];
		
		self.musicView.score = importer.score;
		[self.musicView setNeedsDisplay];
		
		[importer release];
		
		TAMusicPart *part = [self.musicView.score.parts objectAtIndex:0];
		NSString *name = part.name ? part.name : @"Untitled Part";
		[_part setTitle:name forState:UIControlStateNormal];
		[_part sizeToFit];
	
		[self setScoreTitle:self.musicView.score.title];
	
				
		if ( self.modalViewController )
		{
			[self dismissModalViewControllerAnimated:YES];
		}
		else
		{
			[self.scorePopoverController dismissPopoverAnimated:YES];
		}
	}
	else
	{
		TAMusicPart *part = [self.musicView.score.parts objectAtIndex:indexPath.row];
		NSString *name = part.name ? part.name : @"Untitled Part";
		[_part setTitle:name forState:UIControlStateNormal];
		[_part sizeToFit];
		
		self.musicView.part = part;
		[self.musicView setNeedsDisplay];
		
		if ( self.modalViewController )
		{
			[self dismissModalViewControllerAnimated:YES];
		}
		else
		{
			[self.scorePopoverController dismissPopoverAnimated:YES];
		}		
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

	if ( [tableView isEqual:self.scoreTableViewController.tableView] )
	{
		cell.textLabel.text = [self.files objectAtIndex:indexPath.row];
	}
	else
	{
		TAMusicPart *part =  [self.musicView.score.parts objectAtIndex:indexPath.row];

		cell.textLabel.text = part.name;
	}
		
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger count;

	if ( [tableView isEqual:self.scoreTableViewController.tableView] )
	{
		count = [self.files count];
	}
	else
	{	
		count = [self.musicView.score.parts count];
	}
	
	return count;
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

- (UITableViewController *)partsTableViewController
{
	if ( ! _partsTableViewController )
	{
		_partsTableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
		_partsTableViewController.tableView.dataSource = self;
		_partsTableViewController.tableView.delegate = self;
	}

	return _partsTableViewController;
}

- (UILabel *)scoreTitle
{
	if ( ! _scoreTitle )
	{
		_scoreTitle = [[UILabel alloc] init];
		_scoreTitle.text = @"Untited Score";
		_scoreTitle.font = [UIFont boldSystemFontOfSize:18.0f];
		_scoreTitle.textAlignment = UITextAlignmentCenter;
		[_scoreTitle sizeToFit];
		_scoreTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	}
	
	return _scoreTitle;
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

//		if ( [_musicView.score numberOfParts] > 1 )
//		{
//			
//		}

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
	[_files release];
	[_musicView release];
	[_scoreTitle release];

	[_partsTableViewController release];
	[_scoreTableViewController release];

	[_scorePopoverController release];
	[super dealloc];
}

@end
