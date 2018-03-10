//
//  CollectionOfElementsViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CollectionOfElementsViewController.h"
#import "CollectionOfElementsView.h"

@interface CollectionOfElementsViewController ()
@property (nonatomic, strong) CollectionOfElementsView *collenctionView;
@end

@implementation CollectionOfElementsViewController

@synthesize elementArray=mElementArray;
@synthesize collenctionView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [[UIApplication sharedApplication] setStatusBarHidden: YES];
    collenctionView = [[CollectionOfElementsView alloc] initWithFrame: [[UIScreen mainScreen] bounds] andElementsArray: [self elementArray]];
    [collenctionView setDelegate: self];
    [self setView: collenctionView];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
    NSDictionary *elementsDict = [[self elementArray] objectAtIndex: 0];
    [[collenctionView nameLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Name: %@", nil), NSLocalizedString([elementsDict objectForKey: @"Name"], nil)]];
    [[collenctionView massLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Masse: %@", nil), [elementsDict objectForKey: @"Atommasse"]]];
    [[collenctionView elConfigLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"El.-Konf.: %@", nil), [elementsDict objectForKey: @"ElKonfi"]]];
    [[collenctionView periodeLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Periode: %@", nil), [elementsDict objectForKey: @"Periode"]]];
    [[collenctionView gruppeLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Gruppe: %@", nil), NSLocalizedString([elementsDict objectForKey: @"Gruppe"], nil)]];
    [[collenctionView paulingLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Pauling-El.neg.: %@", nil), [elementsDict objectForKey: @"Pauling"]]];
    [[collenctionView abkLabel] setText: [elementsDict objectForKey: @"Abk"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    return YES;
}

//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [self dismissModalViewControllerAnimated: YES];
//}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self dismissModalViewControllerAnimated: YES];
    }
}

- (void)changeColor: (id)sender {
    NSDictionary *colorDictionary = @{@"Gas": @0.2f, @"Metall": @0.3f, @"Halbleiter": @0.4f, @"Ferromagnetikum": @0.5f, @"Halbmetall": @0.6f, @"Flüssigkeit": @0.7f, @"Flüssigkeit, Metall": @0.8f};
//    NSDictionary *cristalStructDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithFloat: 0.2], @"hexagonal", [NSNumber numberWithFloat: 0.3],@"kubischraumzentriert", [NSNumber numberWithFloat: 0.4],@"rhomboedrisch", [NSNumber numberWithFloat: 0.5],@"orthorhombisch", [NSNumber numberWithFloat: 0.6],@"kubisch", [NSNumber numberWithFloat: 0.7], @"kubischfl.zentriert", [NSNumber numberWithFloat: 0.8], @"Diamant", nil]; 
    UISegmentedControl *segmentedControl = sender;
    NSLog(@"[segmentedControl  selectedSegmentIndex]: %d", [segmentedControl selectedSegmentIndex]);
    for (int i = 0; i < [[self elementArray] count]; i++) {
        NSDictionary *elementsDict = [[self elementArray] objectAtIndex: i];
        CGFloat colorFloat = 0.0f;
        switch ([segmentedControl selectedSegmentIndex]) {
            case 0:
                colorFloat = 0.7f-[[elementsDict objectForKey: @"Atommasse"] floatValue]/kMaxMass;
                break;
            case 1:
                colorFloat = [[colorDictionary objectForKey: [elementsDict objectForKey: @"Phase (Normbed.)"]] floatValue];
                break;
            case 2:
                colorFloat = 0.7f-[[elementsDict objectForKey: @"Pauling"] floatValue]/kMaxPauling;
                break;
                
            default:
                break;
        }
        [[[collenctionView buttonArray] objectAtIndex: i] setBackgroundColor: [UIColor colorWithRed: colorFloat green: colorFloat blue: colorFloat alpha: 1.0f]];
    }
//    [cristalStructDictionary release];
    [collenctionView setNeedsDisplay];
}

- (void)elementButtonPressed: (id)sender {
    NSDictionary *elementsDict = [[self elementArray] objectAtIndex: [sender tag]];
    [[collenctionView nameLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Name: %@", nil), NSLocalizedString([elementsDict objectForKey: @"Name"], nil)]];
    [[collenctionView massLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Masse: %@", nil), [elementsDict objectForKey: @"Atommasse"]]];
    [[collenctionView elConfigLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"El.-Konf.: %@", nil), [elementsDict objectForKey: @"ElKonfi"]]];
    [[collenctionView periodeLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Periode: %@", nil), [elementsDict objectForKey: @"Periode"]]];
    [[collenctionView gruppeLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Gruppe: %@", nil), NSLocalizedString([elementsDict objectForKey: @"Gruppe"], nil)]];
    [[collenctionView paulingLabel] setText: [NSString stringWithFormat: NSLocalizedString(@"Pauling-El.neg.: %@", nil), [elementsDict objectForKey: @"Pauling"]]];
    [[collenctionView abkLabel] setText: [elementsDict objectForKey: @"Abk"]];
    
}

@end
