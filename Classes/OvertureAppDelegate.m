//
//  OvertureAppDelegate.m
//  Overture
//
//  Created by Tom Krush on 8/15/10.
//  Copyright Tweakie Apps 2010. All rights reserved.
//

#import "OvertureAppDelegate.h"
#import "TAMusic.h"

@implementation OvertureAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    // Override point for customization after application launch.

	NSString *path = [[NSBundle mainBundle] pathForResource:@"01a-Pitches-Pitches" ofType:@"xml"];
	
	TAMusicXMLImporter *importer = [[TAMusicXMLImporter alloc] initWithContentsOfFile:path];
	
	TAMusicScore *score = importer.score;
	
	NSLog(@"%@", score.title);
	NSLog(@"Number of Parts: %d", [score numberOfParts]);
	NSLog(@"Parts %@", [score.parts valueForKey:@"name"]);
	
	[importer release];
	
	
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
