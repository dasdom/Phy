//  Created by Dominik Hauser on 21.04.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "PhysFormViewController.h"
#import "PhysFormAppDelegate.h"
#import "DestignatedCalculaterViewController.h"
#import "ChemieTableViewController.h"
#import "ElementsDetailViewController.h"

#import "GeneralCalculatorViewController.h"

#import "DetailFormula.h"

#import <sqlite3.h>

@implementation PhysFormViewController

@synthesize tableDataSource;
@synthesize currentTitle;
@synthesize currentLevel;
@synthesize numberOfSections;
@synthesize namesOfSections;
@synthesize listOfItems;

@synthesize listOfAllItems;
@synthesize searchBar;

@synthesize iTunesURL;

// Create the view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
    /*
    UIImageView *backgroundView0 = [[UIImageView alloc] initWithFrame: 
                                    CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 1000.0f)];
    [backgroundView0 setImage: [UIImage imageNamed: @"background2.png"]];
    [[self tableView] setBackgroundView: backgroundView0];
    [backgroundView0 release];
    
    [[[self navigationController] navigationBar] setTranslucent: YES];
    */
    
	// listOfItems will hold arrays: one array of dictionaries for every section
	listOfItems = [[NSMutableArray alloc] init];
	
	//listOfAllItems = [[NSMutableArray alloc] init];
	
	// Are we at the root of the navigation?
	if (currentLevel == 0) {
		// Create the AppDelegate
		PhysFormAppDelegate *AppDelegate = (PhysFormAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		// Set the first array to the tableDateSource of the ViewController 
		self.tableDataSource = [AppDelegate.data objectForKey: @"Rows"];
		
		// There is a section for physics, one for math and one for chemics right now
#ifdef LITE_VERSION
		self.numberOfSections = 4;
#else
		self.numberOfSections = 4;
#endif
		for (int i = 0; i < self.numberOfSections; i++) {
			// Each element (array) in tableDataSource represents a section and therefore is an array of dictionaries
			NSArray *tempArray = [self.tableDataSource objectAtIndex: i];
			[listOfItems addObject: tempArray];
		}
#ifdef LITE_VERSION		
		self.navigationItem.title = @"Phy Lite";
		self.currentTitle = @"Phy Lite";
#else
		self.navigationItem.title = @"Phy";
		self.currentTitle = @"Phy";
#endif
	} else {
		if (self.numberOfSections == 1) {
			// If there is only one section tableDateSource should already be the array with dictionaries we are interrested in
			// Add array to listOfItems
			[listOfItems addObject: self.tableDataSource];		
		} else {
			for (int i = 0; i < self.numberOfSections; i++) {
				// Each element (array) in tableDataSource represents a section and therefore is an array of dictionarys
				NSArray *tempArray = [self.tableDataSource objectAtIndex: i];
				[listOfItems addObject: tempArray];
			}

			NSSet *titleSet = [[NSSet alloc] initWithObjects: @"Mechanik", @"Relativitätstheorie", 
							   @"Fluidmechanik", @"Elektrodynamik", @"Wärme", @"Strahlenoptik", @"Wellenoptik",
							   @"Physikalische Konstanten", 
							   @"Chemische Elemente", @"Kegelschnitte", @"Koordinatensysteme", @"Vektoren", 
							   @"Komplexe Zahlen", 
							   @"trigonometrische Funktionen", @"Taylorreihen", @"Stammfunktionen", 
							   @"Statistik", 
							   @"Physik Formeln", @"Gravitationsbeschleunigung",
							   @"Gravitationskonstante", @"Vakuumlichtgeschwindigkeit",
							   @"absoluter Nullpunkt", @"Avogadrozahl", @"Boltzmannkonstante", 
							   @"allgemeine Gaskonstante", @"Molvolumen eines idealen Gases", 
							   @"Normdruck", @"Tripelpunkt des Wassers", 
							   @"Elementarladung", @"magnetische Feldkonstante",
							   @"Sommerfeldsche Feinstrukturkonstante", 
							   @"inverse Sommerfeldsche Feinstrukturkonstante",
							   @"Plancksches Wirkungsquantum", 
							   @"reduziertes Plancksches Wirkungsquantum",
							   @"Ruhemasse des Elektrons", 
							   @"Ruhemasse des Neutrons", 
							   @"Ruhemasse des Protons", nil];
			NSSet *subSet = [[NSSet alloc] initWithObjects: currentTitle, nil];
			if (![subSet isSubsetOfSet: titleSet]) {
                favorites = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(addButtonPressed)];
				self.navigationItem.rightBarButtonItem = favorites;
			}
		}
		// Set a localized string as title in the navigation bar
		self.navigationItem.title = NSLocalizedString(currentTitle, @"current title");
	}
	//[listOfAllItems addObjectsFromArray: listOfItems];
	listOfAllItems = [[NSArray alloc] initWithArray: listOfItems];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSSet *titleSet = [[NSSet alloc] initWithObjects: @"Mechanik", @"Relativitätstheorie", @"Fluidmechanik", @"Elektrodynamik", @"Wärme", @"Strahlenoptik", @"Wellenoptik", @"Physikalische Konstanten", @"Chemische Elemente", @"trigonometrische Funktionen", nil];
    NSSet *subSet = [[NSSet alloc] initWithObjects: self.currentTitle, nil];
    if ([subSet isSubsetOfSet: titleSet]) {
        searchBar = [[UISearchBar alloc] initWithFrame: self.tableView.bounds];
        [searchBar sizeToFit];
        
        searchBar.delegate = self;
        
        self.tableView.tableHeaderView = searchBar;
    }
    [searchBar setShowsCancelButton: YES];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyIdentifier"];
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return [self.listOfItems count];
}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
	// Remember: each element in listOfItems is an array of dictionaries
	NSArray *tempArray = [self.listOfItems objectAtIndex: section];
	return [tempArray count];
}

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection: (NSInteger)section {
	if (self.numberOfSections == 1)
		return @"";
	//if ([self.namesOfSections count] == 1)
	//	return @"";
	if ([self.namesOfSections count] > section)
		return NSLocalizedString([self.namesOfSections objectAtIndex: section], @"section titles");
	else 
		return @"";
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
	
    NSArray *array = self.listOfItems[indexPath.section];
	
	NSInteger row = indexPath.row;
	NSDictionary *dictionary = array[row];
	
	NSString *title = [dictionary objectForKey: @"Title"];

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MyIdentifier" forIndexPath:indexPath];

    if ([dictionary objectForKey: @"noText"]) {
        cell.textLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.textLabel.text = NSLocalizedString(title, @"Localized cell text");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if ([dictionary objectForKey: @"textForMoreInfo"] != nil) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([dictionary objectForKey: @"calculator"] != nil) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *imageName = NSLocalizedString([dictionary objectForKey: title], @"image");
    
    // Set font
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
            
    // Check if there is an image
    if ([imageName length] != 0) {
        if ([dictionary objectForKey: @"AbkBool"] != nil) {
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        } else {
            // If there is an image set the text alignment to right
            cell.textLabel.textAlignment = NSTextAlignmentRight;
        }
        UIImage *bigImage = [UIImage imageNamed: imageName];
        if (!bigImage) {
            NSLog(@"missing image: >>>%@<<<", imageName);
        }
        cell.imageView.image = bigImage;
    }
    cell.textLabel.font = font;
	
	return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
	// Get the array holding the dictionaries from listOfItems
	NSArray *array = [self.listOfItems objectAtIndex: indexPath.section];
	
	// Get the dictionary of the data source
	NSDictionary *dictionary = [array objectAtIndex: indexPath.row];
	
	// Get the Child; the Child holds the lext (deeper) level 
	NSArray *childArray = [dictionary objectForKey: @"Child"];
	
	// If there is a child construct a table view for this child
	if ([childArray count] != 0) {
		
		// Init a table view 
		NSString *title = [dictionary objectForKey: @"Title"];
		
		
		if ([title isEqualToString: @"Chemische Elemente"]) {
            ChemieTableViewController *chemieTableViewController = [[ChemieTableViewController alloc] initWithStyle: UITableViewStylePlain];
            [chemieTableViewController setElementsDictArray: childArray];
//            [[self navigationController] pushViewController: chemieTableViewController animated: YES];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: chemieTableViewController];
            [navController setModalTransitionStyle: UIModalTransitionStyleFlipHorizontal ];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [[self navigationController] pushViewController: chemieTableViewController animated: YES];
            } else {
                [self presentModalViewController: navController animated: YES];
            }
        } else {
            NSSet *subSet = [[NSSet alloc] initWithObjects: title, nil];
            NSSet *titleSet = [[NSSet alloc] initWithObjects: @"Mechanik", @"Relativitätstheorie",
                               @"Fluidmechanik", @"Elektrodynamik", @"Wärme", @"Strahlenoptik", @"Wellenoptik",
                               @"Quantenmechanik", @"Atomphysik",
                               @"Physikalische Konstanten",
                               //@"Chemische Elemente",
                               @"Kegelschnitte", @"Koordinatensysteme", @"Vektoren",
                               @"Komplexe Zahlen",
                               @"trigonometrische Funktionen", @"Taylorreihen", @"Stammfunktionen",
                               @"Statistik", nil];
            PhysFormViewController *subViewController;
            if ([subSet isSubsetOfSet: titleSet]) {
                subViewController = [[PhysFormViewController alloc] initWithStyle: UITableViewStylePlain];
            } else {
                subViewController = [[PhysFormViewController alloc] initWithStyle: UITableViewStyleGrouped];
            }
            subViewController.currentLevel += 1;
            
            // Set the title to the subview
            subViewController.currentTitle = title;
            
            // Get number and names of the sections for the subview
            NSString *integerString = [dictionary objectForKey: @"numberOfSections"]; 
            subViewController.numberOfSections = [integerString integerValue];
            subViewController.namesOfSections = [dictionary objectForKey: @"namesOfSections"];
            
            // Set the data source for the next table view
            subViewController.tableDataSource = childArray;
            
            // push the table view onto the navigationController
            [self.navigationController pushViewController: subViewController animated: YES];
            
            // release the allocated subViewController
		}
    } else if ([dictionary objectForKey: @"calculator"] || [dictionary objectForKey: @"textForMoreInfo"] != nil) {
        // Allocate a DestignatedCalculatorViewController
        DestignatedCalculaterViewController *subViewController = [[DestignatedCalculaterViewController alloc] init];

        // Get the different strings to print from the dictionary and set them
        subViewController.stringForLabelNull = [dictionary objectForKey: @"stringForLabelNull"];
        subViewController.stringForUnitLabel = [dictionary objectForKey: @"stringForUnitLabel"];
        subViewController.textFile = NSLocalizedString([dictionary objectForKey: @"textForMoreInfo"], @"Erklaerung");

        // the value of calculator is the parameter which has to be squared; calculator == 0 -> no squared parameter
        NSString *integerString = [dictionary objectForKey: @"calculator"];
        subViewController.squarePara = [integerString integerValue];

        // Get the placeholder for the fields from the dictionary and set them
        subViewController.stringForFieldsAbove = [dictionary objectForKey: @"stringForFieldsAbove"];
        subViewController.stringForFieldsBelow = [dictionary objectForKey: @"stringForFieldsBelow"];

        // Set the name of the image to draw
        subViewController.nameOfTheImage = [dictionary objectForKey: [dictionary objectForKey: @"Title"]];

        // Push the view onto the navigationController
        [self.navigationController pushViewController: subViewController animated: YES];

        // release the allocated subViewController
	} else if ([dictionary objectForKey: @"chemieBool"] != nil) {
		ElementsDetailViewController *subViewController = [[ElementsDetailViewController alloc] init];
		
		subViewController.name = NSLocalizedString([dictionary objectForKey: @"Name"],@"name");
		subViewController.abk = [dictionary objectForKey: @"Abk"];
		subViewController.ordnungszahl = [dictionary objectForKey: @"Ordnungszahl"];
		subViewController.atommasse = [dictionary objectForKey: @"Atommasse"];
		subViewController.elKonfiguration = [dictionary objectForKey: @"ElKonfi"];
		subViewController.periode = [dictionary objectForKey: @"Periode"];
		subViewController.gruppe = [dictionary objectForKey: @"Gruppe"];
		
		[self.navigationController pushViewController: subViewController animated:YES];
		
	} else if ([dictionary objectForKey: @"generalCalculator"] != nil) {
		GeneralCalculatorViewController *subViewController = [[GeneralCalculatorViewController alloc] init];

		// Push the view onto the navigationController
		[self.navigationController pushViewController: subViewController animated: YES];
		
		// release the allocated subViewController
		
	} else if ([dictionary objectForKey: @"link"] != nil) {
		NSLog(@"open link");
		NSURL *url = [NSURL URLWithString: [dictionary objectForKey: @"linkToAppStore"]];
		//[[UIApplication sharedApplication] openURL: url];
		[self openReferralURL: url];
	}
	
	
}

// Process a LinkShare/TradeDoubler/DGM URL to something iPhone can handle
- (void)openReferralURL:(NSURL *)referralURL {
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:referralURL] delegate:self];
}
// Save the most recent URL in case multiple redirects occur
// "iTunesURL" is an NSURL property in your class declaration
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    self.iTunesURL = [response URL];
    return request;
}

// No more redirects; use the last URL saved
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[UIApplication sharedApplication] openURL:self.iTunesURL];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	NSString *returnString = @"";
#ifdef LITE_VERSION 
	NSString *titleString = @"Phy Lite";
#else
	NSString *titleString = @"Phy";
#endif
	if (section == [self numberOfSections]-1 && [[[self navigationItem] title] isEqualToString: titleString]) {
		returnString = NSLocalizedString(@"Irrtümer vorbehalten", @"");
	} else if (section == [self numberOfSections]-1 && [[[self navigationItem] title] isEqualToString: @"Formeln üben (Werbung)"]) {
		returnString = NSLocalizedString(@"PhyLer ist ein iOS-App mit dem Sie physikaliche Formeln üben können. Mit einem Klick werden Sie zum App-Store weitergeleitet. Vielen Dank für Ihr Interesse!", @"");
	}
	return returnString;
}

//- (void)searchBarSearchButtonClicked: (UISearchBar *)aSearchBar {
- (void)searchBar:(UISearchBar *)aSearchBar textDidChange:(NSString *)searchText {  
	//[aSearchBar endEditing:YES];
	
	[listOfItems removeAllObjects];
	NSString *query = aSearchBar.text;
	
	if (query.length == 0) {
		[listOfItems addObjectsFromArray: listOfAllItems];
		self.numberOfSections = [self.namesOfSections count];
	} else {
		self.numberOfSections = 1;
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < [listOfAllItems count]; i++) {
			NSArray *array = [listOfAllItems objectAtIndex: i];
			for (int j = 0; j < [array count]; j++) {
				NSDictionary *dictionary = [array objectAtIndex: j];
				NSString *title = [dictionary objectForKey: @"Title"];
				NSRange range = [NSLocalizedString(title,@"") rangeOfString:query options:NSCaseInsensitiveSearch];
				
				if (range.length > 0) {
					[tempArray addObject: dictionary];
				}
			}
		}
		[listOfItems addObject: tempArray];
	}
	[self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked: (UISearchBar *)aSearchBar {
	[aSearchBar endEditing:YES];
	[listOfItems removeAllObjects];
	[listOfItems addObjectsFromArray: listOfAllItems];
	self.numberOfSections = [self.namesOfSections count];
	aSearchBar.text = @"";
	[self.tableView reloadData];
}

- (void)addButtonPressed {
	NSArray *array = [self.listOfItems objectAtIndex: 0];
	NSDictionary *dictionary = [array objectAtIndex: 0];
	
	// Set cellIdentifier for cell at index
	NSString *notificationString = [dictionary objectForKey: @"Formula"];
		
	UIAlertView *alert; 
	
	if (notificationString != nil) {
		alert = [[UIAlertView alloc] initWithTitle:@"Export" message:@"Add/Send formula to"
													delegate:self cancelButtonTitle:@"Cancel" 
											otherButtonTitles:@"Favorites", @"Calculator", nil];
	} else {
		alert = [[UIAlertView alloc] initWithTitle:@"Export" message:@"Add formula to"
										  delegate:self cancelButtonTitle:@"Cancel" 
								 otherButtonTitles:@"Favorites", nil];
	}

	[alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// use "buttonIndex" to decide your action
	//
	if (buttonIndex == 1) {
		NSLog(@"Favorites");
		[self addToFavorites];
	} else if (buttonIndex == 2) {
		NSLog(@"Calculator");
		[self sendNotificationToCalc];
	}
}

- (void)addToFavorites {
	
	NSInteger sections = [self.listOfItems count];
	NSLog(@"sections: %d", sections);
	for (int i = 0; i < sections; i++) {
		NSLog(@"names: %@", [self.namesOfSections objectAtIndex: i]);
	}
	NSArray *array = [self.listOfItems objectAtIndex: 0];
	NSDictionary *dictionary = [array objectAtIndex: 0];
	
	// Set cellIdentifier for cell at index
	NSString *name = [dictionary objectForKey: @"Title"];
	
	NSString *imageName = NSLocalizedString([dictionary objectForKey: name], @"image");
	
	NSLog(@"imageName: %@", imageName);

	PhysFormAppDelegate *AppDelegate = (PhysFormAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	DetailFormula *detailFormula = [[DetailFormula alloc] init];
	detailFormula.formulaName = [self.namesOfSections objectAtIndex: 0];
	detailFormula.imageName = imageName;
	[AppDelegate addDetailFormula: detailFormula];
	//[self formulaAdded: detailFormula.formulaName];
}

- (void)formulaAdded: (NSString *)formulaName {
	NSString *string = [NSString stringWithFormat: 
						NSLocalizedString(@"Formel '%@' wurde zu den Favoriten hinzugefügt.",@""), 
						NSLocalizedString(formulaName, @"")];
	formulaAlert = [[UIAlertView alloc] 
					initWithTitle: NSLocalizedString(@"Formel hinzugefügt", @"")
					message: string
					delegate: self 
					cancelButtonTitle: nil 
					otherButtonTitles: @"OK", nil];
	formulaAlert.delegate = self;
	[formulaAlert show];
}

- (void)sendNotificationToCalc {
	
	NSInteger sections = [self.listOfItems count];
	NSLog(@"sections: %d", sections);
	for (int i = 0; i < sections; i++) {
		NSLog(@"names: %@", [self.namesOfSections objectAtIndex: i]);
	}
	NSArray *array = [self.listOfItems objectAtIndex: 0];
	NSDictionary *dictionary = [array objectAtIndex: 0];
	
	// Set cellIdentifier for cell at index
	NSString *notificationString = [dictionary objectForKey: @"Formula"];
	
	NSLog(@"notificationString: %@", notificationString);
	NSDictionary *userInfo = @{@"Formula": notificationString};
	[[NSNotificationCenter defaultCenter] postNotificationName: @"FormulaIsSent" object: self 
													  userInfo: userInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}



@end
