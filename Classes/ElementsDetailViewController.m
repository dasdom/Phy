//
//  ElementsDetailViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 20.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ElementsDetailViewController.h"

@interface ElementsDetailViewController ()
- (UILabel*)labelWithFrame: (CGRect)pFrame andText: (NSString*)pText;
@end

@implementation ElementsDetailViewController

@synthesize name;
@synthesize abk;
@synthesize ordnungszahl;
@synthesize atommasse;
@synthesize periode;
@synthesize gruppe;
@synthesize elKonfiguration;
@synthesize pauling;

@synthesize elementsDict=mElementsDict;

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
	//UIColor *bColor = [[UIColor alloc] initWithRed:0.0 green: 0.0 blue: 0.0 alpha: 1.0];
	UIColor *bColor = [UIColor scrollViewTexturedBackgroundColor];
	UIColor *tColor = [UIColor colorWithRed: 1.0 green: 1.0 blue: 1.0 alpha: 1.0];
	// Define the contentView
	UIView *contentView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = bColor;
	//[contentView setBackgroundColor: [UIColor scrollViewTexturedBackgroundColor]];
    self.view = contentView;
	
	CGRect frame;
	
	frame = CGRectMake(10, 10, 300, 50);
	UILabel *abkLabel = [[UILabel alloc] initWithFrame: frame];
	abkLabel.text = self.abk;
	UIFont *font = [UIFont fontWithName: @"ArialRoundedMTBold" size: 50.0];
	abkLabel.font = font;
	abkLabel.backgroundColor = bColor;
	abkLabel.textColor = tColor;
	abkLabel.textAlignment = UITextAlignmentCenter;
    abkLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
	[self.view addSubview: abkLabel];
	
	frame = CGRectMake(20, 60, 280, 20);
	UILabel *nameLabel = [[UILabel alloc] initWithFrame: frame];
	nameLabel.text = self.name;
	nameLabel.backgroundColor = bColor;
	nameLabel.textColor = tColor;
	nameLabel.textAlignment = UITextAlignmentCenter;
	[self.view addSubview: nameLabel];
	
    CGFloat x1 = 10.0f;
    CGFloat width1 = 145.0f;
    CGFloat gap = 10.0f;
    CGFloat yPos = 100.0f;
    CGFloat yGap = 5.0f;
    CGFloat height = 20.0f;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *ordnungszahlLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Ordnungszahl:",@"")];
	[self.view addSubview: ordnungszahlLabelLinks];

	frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *ordnungszahlLabelRechts = [self labelWithFrame: frame andText: [self ordnungszahl]];
	[self.view addSubview: ordnungszahlLabelRechts];
	
    yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *atommasseLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Atommasse:",@"")];
	[self.view addSubview: atommasseLabelLinks];
	
	frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *atommasseLabelRechts = [self labelWithFrame: frame andText: [self atommasse]];
	[self.view addSubview: atommasseLabelRechts];

	yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *elKonfiLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"El.-Konfig.:",@"")];
	[self.view addSubview: elKonfiLabelLinks];
	
	frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *elKonfiLabelRechts = [self labelWithFrame: frame andText: [self elKonfiguration]];
	[self.view addSubview: elKonfiLabelRechts];
	
	yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *periodeLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Periode:",@"")];
	[self.view addSubview: periodeLabelLinks];
	
	frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *periodeLabelRechts = [self labelWithFrame: frame andText: [self periode]];
	[self.view addSubview: periodeLabelRechts];
	
	yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *gruppeLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Gruppe:",@"")];
	[self.view addSubview: gruppeLabelLinks];
	
	frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *gruppeLabelRechts = [self labelWithFrame: frame andText: NSLocalizedString([self gruppe], nil)];
    [self.view addSubview: gruppeLabelRechts];
	
	yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *paulingLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Pauling-El.neg.:",@"")];
    [self.view addSubview: paulingLabelLinks];
	
	frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *paulingLabelRechts = [self labelWithFrame: frame andText: [[self elementsDict] objectForKey: @"Pauling"]];
	[self.view addSubview: paulingLabelRechts];
	
//    yPos += yGap+height;
//	frame = CGRectMake(x1, yPos, width1, height);
//	UILabel *protonenLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Anzahl Protonen:",@"")];
//    [self.view addSubview: protonenLabelLinks];
//	
//    yPos += yGap+height;
//	frame = CGRectMake(x1, yPos, width1, height);
//	UILabel *neutronenLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Anzahl Neutronen:",@"")];
//    [self.view addSubview: neutronenLabelLinks];
	
    yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *radioaktivesIsotopLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"wich. radioak. Isotop:",@"")];
    [self.view addSubview: radioaktivesIsotopLinks];
	
    frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *radioaktivesIsotopRechts = [self labelWithFrame: frame andText: [[self elementsDict] objectForKey: @"Wichtigstes radioaktives Isotop"]];
	[self.view addSubview: radioaktivesIsotopRechts];
    
    yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *zerfallsartLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Zerfallsart:",@"")];
    [self.view addSubview: zerfallsartLinks];
	
    frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *zerfallsartRechts = [self labelWithFrame: frame andText: [[self elementsDict] objectForKey: @"Zerfallsart"]];
	[self.view addSubview: zerfallsartRechts];
    
    yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *lebensdauerLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Lebensdauer:",@"")];
    [self.view addSubview: lebensdauerLinks];
	
    frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *lebensdauerRechts = [self labelWithFrame: frame andText: [[self elementsDict] objectForKey: @"Lebensdauer"]];
	[self.view addSubview: lebensdauerRechts];
    
    yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *phaseLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Phase (Normbed.):",@"")];
    [self.view addSubview: phaseLinks];
	
    frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *phaseRechts = [self labelWithFrame: frame andText: NSLocalizedString([[self elementsDict] objectForKey: @"Phase (Normbed.)"], nil)];
	[self.view addSubview: phaseRechts];
    
    yPos += yGap+height;
	frame = CGRectMake(x1, yPos, width1, height);
	UILabel *kristallstrukturLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Kristallstruktur:",@"")];
    [self.view addSubview: kristallstrukturLinks];
	
    frame = CGRectMake(x1+width1+gap, yPos, width1, height);
	UILabel *kristallstrukturRechts = [self labelWithFrame: frame andText: NSLocalizedString([[self elementsDict] objectForKey: @"Kristallstruktur"], nil)];
	[self.view addSubview: kristallstrukturRechts];
    
}

- (UILabel*)labelWithFrame: (CGRect)pFrame andText: (NSString*)pText {
    UILabel *label = [[UILabel alloc] initWithFrame: pFrame];
    [label setText: pText];
    UIColor *bColor = [UIColor grayColor];
	UIColor *tColor = [UIColor colorWithRed: 1.0 green: 1.0 blue: 1.0 alpha: 1.0];
    [label setBackgroundColor: bColor];
    [label setTextColor: tColor];
    [label setTextAlignment: NSTextAlignmentLeft];
    [label setFont: [UIFont systemFontOfSize: 15.0f]];
    return label;
}

@end
