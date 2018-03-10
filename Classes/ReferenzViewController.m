//
//  ReferenzViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ReferenzViewController.h"


@implementation ReferenzViewController

@synthesize gasArray, fluessigArray, festArray;
@synthesize dict, eigenschaften, dict2;
@synthesize mainDict;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *dataPath = [path stringByAppendingPathComponent: @"Referenz.plist"];
	mainDict = [[NSDictionary alloc] initWithContentsOfFile: dataPath];
	//gasArray = [[NSArray alloc] initWithArray: [mainDict objectForKey: @"gasfoermig"] copyItems: YES];
	[self setGasArray: [mainDict objectForKey: @"gasfoermig"]];
	//fluessigArray = [[NSArray alloc] initWithArray: [mainDict objectForKey: @"fluessig"] copyItems: YES];
	[self setFluessigArray: [mainDict objectForKey: @"fluessig"]];
	//festArray = [[NSArray alloc] initWithArray: [mainDict objectForKey: @"fest"] copyItems: YES];
	[self setFestArray: [mainDict objectForKey: @"fest"]];
	
	//dict = [[NSDictionary alloc] initWithDictionary: [gasArray objectAtIndex: 0] copyItems: YES];
	[self setDict: [gasArray objectAtIndex: 0]];
	//eigenschaften = [[NSArray alloc] initWithArray: [dict objectForKey: @"Eigenschaften"] copyItems: YES];
	[self setEigenschaften: [dict objectForKey: @"Eigenschaften"]];
	//dict2 = [[NSDictionary alloc] initWithDictionary: [eigenschaften objectAtIndex: 0] copyItems: YES];
	[self setDict2: [eigenschaften objectAtIndex: 0]];
	
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		screenRect.size.height = screenRect.size.height/2-20;
	}
	referenzView = [[ReferenzView alloc] initWithFrame: screenRect];
	
	referenzView.pickerView.delegate = self;
	
	referenzView.outputValue.text = [NSString stringWithFormat: @"%@ %@", 
									 NSLocalizedString([dict2 objectForKey: @"Wert"],@""),
									 [dict2 objectForKey: @"Einheit"]];
	referenzView.material.text = NSLocalizedString([dict objectForKey: @"Name"],@"");
	referenzView.eigenschaft.text = NSLocalizedString([dict2 objectForKey: @"Name"],@"");
	referenzView.bedingung.text = [dict2 objectForKey: @"Bedingung"];
	self.view = referenzView;
	
	[referenzView.segmentedControl addTarget: self 
	 action: @selector(segmentAction:) forControlEvents: UIControlEventValueChanged];
	referenzView.segmentedControl.selectedSegmentIndex = 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	switch (component) {
		case 0:
			//[referenzView.pickerView selectRow: 0 inComponent: 1 animated: NO];
			switch (segmentIndex) {
				case 0:
					dict = [gasArray objectAtIndex: row];
					break;
				case 1:
					dict = [fluessigArray objectAtIndex: row];
					break;
				case 2:
					dict = [festArray objectAtIndex: row];
					break;
				default:
					break;
			}
			eigenschaften = [dict objectForKey: @"Eigenschaften"];
			if ([referenzView.pickerView selectedRowInComponent: 1] > [eigenschaften count] - 1) {
				[referenzView.pickerView selectRow: 0 inComponent: 1 animated: NO];	
				dict2 =	[eigenschaften objectAtIndex: 0];
			} else {
				dict2 =	[eigenschaften objectAtIndex: [referenzView.pickerView selectedRowInComponent: 1]];
			}
			referenzView.material.text = NSLocalizedString([dict objectForKey: @"Name"],@"");
			break;
		case 1:
			dict2 =	[eigenschaften objectAtIndex: row];
			break;
		default:
			break;
	}
	referenzView.outputValue.text = [NSString stringWithFormat: @"%@ %@", 
									 NSLocalizedString([dict2 objectForKey: @"Wert"],@""),
									 [dict2 objectForKey: @"Einheit"]];
	referenzView.bedingung.text = [dict2 objectForKey: @"Bedingung"];
	referenzView.eigenschaft.text = NSLocalizedString([dict2 objectForKey: @"Name"],@"");
		
	[referenzView.pickerView reloadAllComponents];
	[self.view setNeedsDisplay];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	NSString *returnString;
	if (component == 0) {
		NSDictionary *tempDict;
		switch (segmentIndex) {
			case 0:
				//tempDict = [[NSDictionary alloc] initWithDictionary: [gasArray objectAtIndex: row]];
				tempDict = [NSDictionary dictionaryWithDictionary: [gasArray objectAtIndex: row]];
				break;
			case 1:
				//tempDict = [[NSDictionary alloc] initWithDictionary: [fluessigArray objectAtIndex: row]];
				tempDict = [NSDictionary dictionaryWithDictionary: [fluessigArray objectAtIndex: row]];
				break;
			case 2:
				//tempDict = [[NSDictionary alloc] initWithDictionary: [festArray objectAtIndex: row]];
				tempDict = [NSDictionary dictionaryWithDictionary: [festArray objectAtIndex: row]];
				break;

			default:
                tempDict = @{};
				break;
		}
		returnString = NSLocalizedString([tempDict objectForKey: @"Name"],@"");
		//[tempDict release];
	} else {
		dict2 = [eigenschaften objectAtIndex: row];
		returnString = NSLocalizedString([dict2 objectForKey: @"Name"],@"");
	}
	return returnString;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSInteger returnInt = 0;
	if (component == 0) {
		switch (segmentIndex) {
			case 0:
				returnInt = [gasArray count];
				break;
			case 1:
				returnInt = [fluessigArray count];
				break;
			case 2:
				returnInt = [festArray count];
				break;

			default:
				break;
		}
	} else {
		returnInt = [eigenschaften count];
	}
	return returnInt;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

- (void)segmentAction: (id)sender {
	segmentIndex = [sender selectedSegmentIndex];
	[referenzView.pickerView selectRow: 0 inComponent: 0 animated: NO];
	[referenzView.pickerView selectRow: 0 inComponent: 1 animated: NO];
	
	switch (segmentIndex) {
		case 0:
			dict = [gasArray objectAtIndex: 0];
			break;
		case 1:
			dict = [fluessigArray objectAtIndex: 0];
			break;
		case 2:
			dict = [festArray objectAtIndex: 0];
			break;
		default:
			break;
	}
	eigenschaften = [dict objectForKey: @"Eigenschaften"];
	referenzView.material.text = NSLocalizedString([dict objectForKey: @"Name"],@"");
	
	dict2 = [eigenschaften objectAtIndex: 0];
	referenzView.outputValue.text = [NSString stringWithFormat: @"%@ %@", 
									 NSLocalizedString([dict2 objectForKey: @"Wert"],@""),
									 [dict2 objectForKey: @"Einheit"]];
	referenzView.bedingung.text = [dict2 objectForKey: @"Bedingung"];
	referenzView.eigenschaft.text = NSLocalizedString([dict2 objectForKey: @"Name"],@"");
	
	[referenzView.pickerView reloadAllComponents]; 
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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




@end
