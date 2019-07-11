//
//  FavoritesViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 05.03.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PhysFormAppDelegate.h"
@class PhysFormAppDelegate;

@interface FavoritesViewController : UITableViewController {
	//NSMutableArray *tableDataSource;
	//NSMutableArray *formulaNames;
	PhysFormAppDelegate *appDelegate;
//	UIAlertView *howToAlert;
	BOOL showHowTo;
}

//- (void)loadtableData;
- (void)howToAddFormulas;

@end
