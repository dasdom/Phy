//
//  HistoryTableViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "HistoryTableViewCell.h"
#import "GeneralCalculatorViewController.h"

@implementation HistoryTableViewController

@synthesize calcDictArray=mCalcDictArray;
@synthesize delegate;
@synthesize isCalcHistory=mIsCalcHistory;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        mCalcDictArray = [[NSArray alloc] init];
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self isCalcHistory]) {
        [self setTitle: NSLocalizedString(@"letzte Berechnungen", nil)];
    } else {
        [self setTitle: NSLocalizedString(@"letzte Ergebnisse", nil)];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"zurück", nil) style: UIBarButtonItemStyleBordered target: self action: @selector(backButtonPressed:)];
    [[self navigationItem] setLeftBarButtonItem: backBarButtonItem];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self calcDictArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryTableViewCell *cell = [HistoryTableViewCell cellForTableView: tableView];
    
    [[cell calcStringTextView] setText: [[[self calcDictArray] objectAtIndex: [indexPath row]] objectForKey: @"calcString"]];
    [[cell solutionLabel] setText: [NSString stringWithFormat: @"= %@", [[[self calcDictArray] objectAtIndex: [indexPath row]] objectForKey: @"solution"]]];

    if ([self isCalcHistory]) {
        [[cell calcStringTextView] setFont: [UIFont boldSystemFontOfSize: 14.0f]];
        [[cell solutionLabel] setFont: [UIFont systemFontOfSize: 14.0f]];
    } else {
        [[cell calcStringTextView] setFont: [UIFont systemFontOfSize: 14.0f]];
        [[cell solutionLabel] setFont: [UIFont boldSystemFontOfSize: 14.0f]];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableString *mutableString; 
    if ([self isCalcHistory]) {
        mutableString = [[NSMutableString alloc] initWithFormat: @"%@_", [[[self calcDictArray] objectAtIndex: [indexPath row]] objectForKey: @"calcString"]];
    } else {
        NSArray *underScore = [[delegate calcString] componentsSeparatedByString:@"_"];
		NSString *tempCalcString = [[NSString alloc] initWithString: [underScore objectAtIndex:0]];
        mutableString = [[NSMutableString alloc] initWithFormat: @"%@%@_", tempCalcString, [[[self calcDictArray] objectAtIndex: [indexPath row]] objectForKey: @"solution"]];
        [mutableString appendString: [underScore objectAtIndex: 1]];
    }
    [[self delegate] setCalcString: mutableString];
    [[[self delegate] calcStringView] setText: [[self delegate] calcString]];
    [self dismissModalViewControllerAnimated: YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)backButtonPressed: (id)sender {
    [self dismissModalViewControllerAnimated: YES];
}

@end
