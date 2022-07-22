//  Created by Dominik Hauser on 20.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

#import "ElementInfoTableViewController.h"
#import "Phy-Swift.h"
#import "ElementInfoCell.h"

typedef NS_ENUM(NSInteger, ElementInfoRow) {
    ElementInfoRowName,
    ElementInfoRowMass,
    ElementInfoRowElectricConfiguration,
    ElementInfoRowPeriode,
    ElementInfoRowGroup,
    ElementInfoRowPauling,
    ElementInfoRowMostImportantRadioactiveIsotope,
    ElementInfoRowDecayType,
    ElementInfoRowLifetime,
    ElementInfoRowPhaseNorm,
    ElementInfoRowCrystalStructure,
    ElementInfoRowNumberOfRows
};

@interface ElementInfoTableViewController ()
@end

@implementation ElementInfoTableViewController

- (instancetype)initWithElement: (ChemElement *)element {
    if (self = [super initWithNibName: nil bundle: nil]) {
        _element = element;
    }
    return self;
}

- (void)setElement: (ChemElement *)element {
    _element = element;

    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerClass: [ElementInfoCell class] forCellReuseIdentifier: [ElementInfoCell identifier]];
}

#pragma mark - Table view data source

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return ElementInfoRowNumberOfRows;
}


- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    ElementInfoCell *cell = [tableView dequeueReusableCellWithIdentifier: [ElementInfoCell identifier] forIndexPath: indexPath];

    NSString *text;
    switch (indexPath.row) {
        case ElementInfoRowName:
            text = [NSString stringWithFormat: NSLocalizedString(@"Name: %@", nil), NSLocalizedString(self.element.name, nil)];
            break;
        case ElementInfoRowMass:
            text = [NSString stringWithFormat: NSLocalizedString(@"Masse: %.6lf", nil), self.element.atomMass];
            break;
        case ElementInfoRowElectricConfiguration:
            text = [NSString stringWithFormat: NSLocalizedString(@"EL.-Konf.: %@", nil), self.element.electronConfiguration];
            break;
        case ElementInfoRowPeriode:
            text = [NSString stringWithFormat: NSLocalizedString(@"Periode: %ld", nil), self.element.period];
            break;
        case ElementInfoRowGroup:
            text = [NSString stringWithFormat: NSLocalizedString(@"Gruppe: %@", nil), self.element.group];
            break;
        case ElementInfoRowPauling:
            text = [NSString stringWithFormat: NSLocalizedString(@"Pauling-El.neg.: %@", nil), self.element.pauling];
            break;
        case ElementInfoRowMostImportantRadioactiveIsotope:
            text = [NSString stringWithFormat: NSLocalizedString(@"Wichtigstes radioaktives Isotop: %@", nil), self.element.mostImportantRadioactiveIsotopeString];
            break;
        case ElementInfoRowDecayType:
            text = [NSString stringWithFormat: NSLocalizedString(@"Zerfallsart: %@", nil), self.element.decayType];
            break;
        case ElementInfoRowLifetime:
            text = [NSString stringWithFormat: NSLocalizedString(@"Lebensdauer: %@", nil), self.element.lifetime];
            break;
        case ElementInfoRowPhaseNorm:
            text = [NSString stringWithFormat: NSLocalizedString(@"Phase (Normbedingungen): %@", nil), NSLocalizedString(self.element.phaseNorm, nil)];
            break;
        case ElementInfoRowCrystalStructure:
            text = [NSString stringWithFormat: NSLocalizedString(@"Kristallstruktur: %@", nil), NSLocalizedString(self.element.crystalStructure, nil)];
            break;
        default:
            break;
    }

    [cell updateWithText: text];

    return cell;
}

@end
