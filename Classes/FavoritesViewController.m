//
//  FavoritesViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 05.03.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FavoritesViewController.h"
#import <sqlite3.h>
#import "DetailFormula.h"
#import "PhysFormAppDelegate.h"

/*
static int MyCallback(void *context, int count, char **values, char **columns) {
	NSMutableArray *array = (NSMutableArray *)context;
	for (int i=0; i < count; i++) {
		const char *nameCString = values[i];
		[array addObject: [NSString stringWithUTF8String: nameCString]];
	}
	return SQLITE_OK;
}
*/

@implementation FavoritesViewController

/*
- (void)loadtableData {
	NSString *file = [[NSBundle mainBundle] pathForResource: @"favorites" ofType: @"db"];
	sqlite3 *database = NULL;
	if (sqlite3_open([file UTF8String], &database) == SQLITE_OK) {
		sqlite3_exec(database, "select imageName from formula", MyCallback, tableDataSource, NULL);
	}
	sqlite3_close(database);
}
*/
- (id)init {
	if (self = [super init]) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		if (![defaults boolForKey: @"noFirstStart"])
			showHowTo = YES;
		[defaults setBool: YES forKey: @"noFirstStart"]; 
	}
	return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [appDelegate.formulaArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	DetailFormula *formulaObj = [appDelegate.formulaArray objectAtIndex: section];
	return NSLocalizedString(formulaObj.formulaName, @"favorites header");
}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
	//return [appDelegate.formulaArray count];
	return 1;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexpath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
	}
	//DetailFormula *formulaObj = [appDelegate.formulaArray objectAtIndex: indexpath.row];
	DetailFormula *formulaObj = [appDelegate.formulaArray objectAtIndex: indexpath.section];
	//cell.text = formulaObj.imageName;
	[[cell imageView] setImage:[UIImage imageNamed:formulaObj.imageName]];
    [cell setBackgroundColor: [UIColor lightGrayColor]];
	return cell;
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle
	forRowAtIndexPath: (NSIndexPath *)indexpath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		DetailFormula *detailFormula = [appDelegate.formulaArray objectAtIndex: indexpath.section];
		[appDelegate removeDetailFormula: detailFormula];
		
		//[self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexpath] 
		 //withRowAnimation: UITableViewRowAnimationFade];
		NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex: indexpath.section];
		[self.tableView deleteSections: indexSet withRowAnimation: UITableViewRowAnimationLeft];
	}
}
 
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewWillAppear:(BOOL)animated {
	if (showHowTo) {
		[self howToAddFormulas];
		showHowTo = NO;
	}
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	appDelegate = [[UIApplication sharedApplication] delegate];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)howToAddFormulas {
	NSString *string = [NSString stringWithString: 
						NSLocalizedString(@"Formeln können im Bereich 'Formulas' durch einen Tab auf den rechten Tabbar-Knopf zu den Favoriten hinzugefügt werden. Formeln koennen durch einen Swipe ueber die Zelle entfernt werden.",@"")];
	howToAlert = [[UIAlertView alloc] 
					initWithTitle: NSLocalizedString(@"How To", @"")
					message: string
					delegate: self 
					cancelButtonTitle: nil 
					otherButtonTitles: @"OK", nil];
	howToAlert.delegate = self;
	[howToAlert show];
}



@end
