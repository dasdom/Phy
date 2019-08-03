//  Created by Dominik Hauser on 20.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ElementsDetailViewController.h"

@implementation ElementsDetailViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	//UIColor *bColor = [[UIColor alloc] initWithRed:0.0 green: 0.0 blue: 0.0 alpha: 1.0];
	UIColor *bColor = [UIColor whiteColor];
	UIColor *tColor = [UIColor blackColor];
	// Define the contentView
	UIView *contentView = [[UIView alloc] init];
	contentView.backgroundColor = bColor;
	//[contentView setBackgroundColor: [UIColor scrollViewTexturedBackgroundColor]];
    self.view = contentView;
		
	UILabel *abkLabel = [[UILabel alloc] init];
	abkLabel.text = self.abk;
	UIFont *font = [UIFont fontWithName: @"ArialRoundedMTBold" size: 50.0];
	abkLabel.font = font;
	abkLabel.backgroundColor = bColor;
	abkLabel.textColor = tColor;
	abkLabel.textAlignment = NSTextAlignmentCenter;
	
	UILabel *nameLabel = [[UILabel alloc] init];
	nameLabel.text = self.name;
	nameLabel.backgroundColor = bColor;
	nameLabel.textColor = tColor;
	nameLabel.textAlignment = NSTextAlignmentCenter;

    UIStackView *topStackView = [[UIStackView alloc] initWithArrangedSubviews:@[abkLabel, nameLabel]];
    topStackView.axis = UILayoutConstraintAxisVertical;
    
	UILabel *ordnungszahlLabelLinks = [self labelWithText: NSLocalizedString(@"Ordnungszahl:",@"")];
	UILabel *ordnungszahlLabelRechts = [self labelWithText: [self ordnungszahl]];
    UIStackView *ordnungszahlStackView = [self infoStackViewWithArrangeViews:@[ordnungszahlLabelLinks, ordnungszahlLabelRechts]];
    
    UILabel *atommasseLabelLinks = [self labelWithText: NSLocalizedString(@"Atommasse:",@"")];
    UILabel *atommasseLabelRechts = [self labelWithText: [self atommasse]];
    UIStackView *atommasseStackView = [self infoStackViewWithArrangeViews:@[atommasseLabelLinks, atommasseLabelRechts]];

    UILabel *elKonfiLabelLinks = [self labelWithText: NSLocalizedString(@"El.-Konfig.:",@"")];
    UILabel *elKonfiLabelRechts = [self labelWithText: [self elKonfiguration]];
    UIStackView *elKonfiStackView = [self infoStackViewWithArrangeViews:@[elKonfiLabelLinks, elKonfiLabelRechts]];
    
    UILabel *periodeLabelLinks = [self labelWithText: NSLocalizedString(@"Periode:",@"")];
    UILabel *periodeLabelRechts = [self labelWithText: [self periode]];
    UIStackView *periodeStackView = [self infoStackViewWithArrangeViews:@[periodeLabelLinks, periodeLabelRechts]];

    UILabel *gruppeLabelLinks = [self labelWithText: NSLocalizedString(@"Gruppe:",@"")];
    UILabel *gruppeLabelRechts = [self labelWithText: NSLocalizedString([self gruppe], nil)];
    UIStackView *gruppeStackView = [self infoStackViewWithArrangeViews:@[gruppeLabelLinks, gruppeLabelRechts]];

    UILabel *paulingLabelLinks = [self labelWithText: NSLocalizedString(@"Pauling-El.neg.:",@"")];
    UILabel *paulingLabelRechts = [self labelWithText: [[self elementsDict] objectForKey: @"Pauling"]];
    UIStackView *paulingStackView = [self infoStackViewWithArrangeViews:@[paulingLabelLinks, paulingLabelRechts]];
    
////    yPos += yGap+height;
////    frame = CGRectMake(x1, yPos, width1, height);
////    UILabel *protonenLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Anzahl Protonen:",@"")];
////    [self.view addSubview: protonenLabelLinks];
////
////    yPos += yGap+height;
////    frame = CGRectMake(x1, yPos, width1, height);
////    UILabel *neutronenLabelLinks = [self labelWithFrame: frame andText: NSLocalizedString(@"Anzahl Neutronen:",@"")];
////    [self.view addSubview: neutronenLabelLinks];
//
    
    UILabel *radioaktivesIsotopLinks = [self labelWithText: NSLocalizedString(@"wich. radioak. Isotop:",@"")];
    UILabel *radioaktivesIsotopRechts = [self labelWithText: [[self elementsDict] objectForKey: @"Wichtigstes radioaktives Isotop"]];
    UIStackView *radioaktivesIsotopStackView = [self infoStackViewWithArrangeViews:@[radioaktivesIsotopLinks, radioaktivesIsotopRechts]];
    
    UILabel *zerfallsartLinks = [self labelWithText: NSLocalizedString(@"Zerfallsart:",@"")];
    UILabel *zerfallsartRechts = [self labelWithText: [[self elementsDict] objectForKey: @"Zerfallsart"]];
    UIStackView *zerfallsartStackView = [self infoStackViewWithArrangeViews:@[zerfallsartLinks, zerfallsartRechts]];
    
    UILabel *lebensdauerLinks = [self labelWithText: NSLocalizedString(@"Lebensdauer:",@"")];
    UILabel *lebensdauerRechts = [self labelWithText: [[self elementsDict] objectForKey: @"Lebensdauer"]];
    UIStackView *lebensdauerStackView = [self infoStackViewWithArrangeViews:@[lebensdauerLinks, lebensdauerRechts]];
    
    UILabel *phaseLinks = [self labelWithText: NSLocalizedString(@"Phase (Normbed.):",@"")];
    UILabel *phaseRechts = [self labelWithText: NSLocalizedString([[self elementsDict] objectForKey: @"Phase (Normbed.)"], nil)];
    UIStackView *phaseStackView = [self infoStackViewWithArrangeViews:@[phaseLinks, phaseRechts]];
    
    UILabel *kristallstrukturLinks = [self labelWithText: NSLocalizedString(@"Kristallstruktur:",@"")];
    UILabel *kristallstrukturRechts = [self labelWithText: NSLocalizedString([[self elementsDict] objectForKey: @"Kristallstruktur"], nil)];
    UIStackView *kristallstrukturStackView = [self infoStackViewWithArrangeViews:@[kristallstrukturLinks, kristallstrukturRechts]];
    
    UIStackView *infoStackView = [[UIStackView alloc] initWithArrangedSubviews:@[ordnungszahlStackView, atommasseStackView, elKonfiStackView, periodeStackView, gruppeStackView, paulingStackView, radioaktivesIsotopStackView, zerfallsartStackView, lebensdauerStackView, phaseStackView, kristallstrukturStackView]];
    infoStackView.axis = UILayoutConstraintAxisVertical;
    infoStackView.spacing = 5;
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[topStackView, infoStackView]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 20;
    
    [self.view addSubview:stackView];
    
    [NSLayoutConstraint activateConstraints:
     @[
       [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8],
       [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-8],
       [stackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:8]
       ]
      ];
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize: 15.0f];
    return label;
}

- (UIStackView *)infoStackViewWithArrangeViews:(NSArray<UIView *> *)arrangeViews {
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:arrangeViews];
    stackView.spacing = 5;
    stackView.distribution = UIStackViewDistributionFillEqually;
    return stackView;
}

@end
