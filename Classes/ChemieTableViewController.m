//
//  ChemieTableViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 18.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChemieTableViewController.h"
#import "ElementsDetailViewController.h"
#import "CollectionOfElementsViewController.h"

@implementation ChemieTableViewController

@synthesize elementsDictArray=mElementsDictArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        mElementsDictArray = [[NSArray alloc] init];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        UIBarButtonItem *dismissBarButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"zurück", nil) style: UIBarButtonItemStylePlain target: self action: @selector(dismiss)];
        [[self navigationItem] setLeftBarButtonItem: dismissBarButton];
    }
    [self setTitle: NSLocalizedString(@"Chemische Elemente", nil)];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return NO;
    }
    return YES;
}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        CollectionOfElementsViewController *collectionOfElementsViewController = [[CollectionOfElementsViewController alloc] init];
//        [collectionOfElementsViewController setElementArray: [self elementsDictArray]];
//        [collectionOfElementsViewController setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
//        [self presentModalViewController: collectionOfElementsViewController animated: YES];
//        [collectionOfElementsViewController release];
//    }
//}
//
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//        CollectionOfElementsViewController *collectionOfElementsViewController = [[CollectionOfElementsViewController alloc] init];
//        [collectionOfElementsViewController setElementArray: [self elementsDictArray]];
//        [collectionOfElementsViewController setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
//        [self presentModalViewController: collectionOfElementsViewController animated: YES];
//        [collectionOfElementsViewController release];
//    }
//}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return;
    }
    if (size.width > size.height) {
        CollectionOfElementsViewController *collectionOfElementsViewController = [[CollectionOfElementsViewController alloc] init];
        [collectionOfElementsViewController setElementArray: [self elementsDictArray]];
        [collectionOfElementsViewController setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self presentViewController:collectionOfElementsViewController animated:YES completion:nil];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self elementsDictArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
    }
    
    NSDictionary *elementsDict = [[self elementsDictArray] objectAtIndex: [indexPath row]];
    [[cell textLabel] setText: NSLocalizedString([elementsDict objectForKey: @"Title"], nil)];
    NSString *detailString = [[NSString alloc] initWithFormat: @"%@  -  m: %@  -  el: %@", [elementsDict objectForKey: @"Abk"], [elementsDict objectForKey: @"Atommasse"], [elementsDict objectForKey: @"ElKonfi"]];
    [[cell detailTextLabel] setText: detailString];
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
    ElementsDetailViewController *subViewController = [[ElementsDetailViewController alloc] init];
    
    NSDictionary *elementsDict = [[self elementsDictArray] objectAtIndex: [indexPath row]];
    subViewController.name = NSLocalizedString([elementsDict objectForKey: @"Name"],@"name");
    subViewController.abk = [elementsDict objectForKey: @"Abk"];
    subViewController.ordnungszahl = [elementsDict objectForKey: @"Ordnungszahl"];
    subViewController.atommasse = [elementsDict objectForKey: @"Atommasse"];
    subViewController.elKonfiguration = [elementsDict objectForKey: @"ElKonfi"];
    subViewController.periode = [elementsDict objectForKey: @"Periode"];
    subViewController.gruppe = [elementsDict objectForKey: @"Gruppe"];
    subViewController.pauling = [elementsDict objectForKey: @"Pauling"];
    
    [subViewController setElementsDict: [[self elementsDictArray] objectAtIndex: [indexPath row]]];
    
    [self.navigationController pushViewController: subViewController animated: YES];
    
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
