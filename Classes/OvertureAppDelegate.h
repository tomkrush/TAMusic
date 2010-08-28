//
//  OvertureAppDelegate.h
//  Overture
//
//  Created by Tom Krush on 8/15/10.
//  Copyright Tweakie Apps 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootController.h"

@interface OvertureAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	RootController *_rootController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, readonly) RootController *rootController;


@end

