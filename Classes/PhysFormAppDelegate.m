//
//  PhysFormAppDelegate.m
//  PhysForm
//
//  Created by Dominik Hauser on 21.04.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "PhysFormAppDelegate.h"
#import "PhysFormViewController.h"
#import "DetailFormula.h"

@implementation PhysFormAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize data;
@synthesize formulaArray;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//- (void)applicationDidFinishLaunching:(UIApplication *)application {   
	NSLog(@"started loading");
	// Get the path to Data.plist:
	// First get the path to the mainBundle
	NSString *path = [[NSBundle mainBundle] bundlePath];
	// than append the name of the file.
#ifdef LITE_VERSION
	NSString *dataPath = [path stringByAppendingPathComponent: @"DataLite.plist"];
#else
	NSString *dataPath = [path stringByAppendingPathComponent: @"Data.plist"];
#endif
	// Initialize the temporal dictionary
	NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile: dataPath];
	
	// Set data source for self; date holds the first dictionary
	self.data = tempDict;
	
	// Get screen bounds
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	
	// Initialize the window
	self.window = [[UIWindow alloc] initWithFrame: screenBounds];
	
	UIView *dummyView = [[UIView alloc] initWithFrame: screenBounds];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		//[window addSubview: dummyView];
	}
	
	//*****************************************************
	[self copyDatabaseIfNeeded];
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.formulaArray = tempArray;
	
	[DetailFormula getInitialDataToDisplay: [self getDBPath]];
	//*****************************************************
	
	// Initialize the tabBarController
	tabBarController = [[UITabBarController alloc] init];
	
	// Initialize the view controller
	viewController = [[PhysFormViewController alloc] initWithStyle: UITableViewStyleGrouped];
	//viewController = [[PhysFormViewController alloc] initWithStyle: UITableViewStylePlain];

	// Initialize the navigation controller and set the title
	navigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
	navigationController.title = @"Formulas";
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		navigationController.view.frame = CGRectMake(0, 20, screenBounds.size.width, screenBounds.size.height/2);
		[dummyView addSubview: [navigationController view]];
	}
	
	// Initialize the general calculator
	generalCalculatorViewController = [[GeneralCalculatorViewController alloc] init];
	generalCalculatorViewController.title = @"Calculator";
	[[NSNotificationCenter defaultCenter] addObserver: generalCalculatorViewController 
											 selector: @selector(receivedFormula:) 
												 name: @"FormulaIsSent" object: nil];

	converterViewController = [[ConverterViewController alloc] init];
	converterViewController.title = @"Converter";
	
	favoritesViewController = [[FavoritesViewController alloc] init];
	favoritesViewController.title = @"Favorites";
	
	referenzViewController = [[ReferenzViewController alloc] init];
	referenzViewController.title = @"Referenz";

    
#ifdef LITE_VERSION
	tabBarController.viewControllers = [NSArray arrayWithObjects: navigationController, 
										favoritesViewController, nil];	
#else
	
	// populate the tabBar
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		tabBarController.viewControllers = @[generalCalculatorViewController, 
											//converterViewController, referenzViewController,
											//favoritesViewController
                                             ];
        tabBarController.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	} else {
		tabBarController.viewControllers = @[navigationController, 
											generalCalculatorViewController, 
                                            converterViewController, referenzViewController,
                                            favoritesViewController
                                             ];
	}

#endif	
	// TODO: How can I get images to the tabBarItems?
	NSArray *array = tabBarController.tabBar.items;
	
	//[[array objectAtIndex:1] setImage: [UIImage imageNamed: @"calc.png"]];
#ifdef LITE_VERSION
	[[array objectAtIndex:0] setImage: [UIImage imageNamed: @"tabbaritem0.png"]];
	[[array objectAtIndex:1] setImage: [UIImage imageNamed: @"tabbaritem4.png"]];
#else
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[[array objectAtIndex:0] setImage: [UIImage imageNamed: @"tabbaritem1.png"]];
//		[[array objectAtIndex:1] setImage: [UIImage imageNamed: @"tabbaritem2.png"]];
//		[[array objectAtIndex:2] setImage: [UIImage imageNamed: @"tabbaritem3.png"]];
//		[[array objectAtIndex:3] setImage: [UIImage imageNamed: @"tabbaritem4.png"]];
	} else {
		[[array objectAtIndex:0] setImage: [UIImage imageNamed: @"tabbaritem0.png"]];
		[[array objectAtIndex:1] setImage: [UIImage imageNamed: @"tabbaritem1.png"]];
        [[array objectAtIndex:2] setImage: [UIImage imageNamed: @"tabbaritem2.png"]];
        [[array objectAtIndex:3] setImage: [UIImage imageNamed: @"tabbaritem3.png"]];
        [[array objectAtIndex:4] setImage: [UIImage imageNamed: @"tabbaritem4.png"]];
	}

	
#endif
	 
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        tabBarController.view.frame = CGRectMake(0, screenBounds.size.height/2+20, screenBounds.size.width, screenBounds.size.height/2-20);
//    }
//    // Add the tabBar to the window
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        [dummyView addSubview: tabBarController.view];
////        UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
////        [splitViewController setViewControllers: [NSArray arrayWithObjects: generalCalculatorViewController, navigationController, nil]];
////        [window setRootViewController: splitViewController];
//        [window addSubview: dummyView];
//    } else {
//        [window addSubview: tabBarController.view];
//    }
    
    window.rootViewController = tabBarController;

	[window makeKeyAndVisible];
	NSLog(@"finished loading");
    
    return true;
}

- (void)copyDatabaseIfNeeded {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath: dbPath];
	
	if (!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] 
								   stringByAppendingPathComponent: @"favorites.db"];
		success = [fileManager copyItemAtPath: defaultDBPath toPath: dbPath error: &error];
		if (!success) {
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", 
					  [error localizedDescription]);
		}
	}
}

- (NSString *)getDBPath {
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
														 NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex: 0];
	return [documentsDir stringByAppendingPathComponent: @"favorites.db"];
}

- (void)removeDetailFormula: (DetailFormula *)detailFormulaObj {
	[detailFormulaObj deleteFormula];
	[formulaArray removeObject: detailFormulaObj];
}

- (void)addDetailFormula: (DetailFormula *)detailFormulaObj {
	[detailFormulaObj addDetailFormula];
	[formulaArray addObject: detailFormulaObj];
	[favoritesViewController.tableView reloadData];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[DetailFormula finalizeStatements];
}



@end
