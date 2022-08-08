//
//  CollectionOfElementsViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CollectionOfElementsViewController.h"
#import "CollectionOfElementsView.h"
#import "ElementInfoTableViewController.h"
#import "Phy-Swift.h"

@interface CollectionOfElementsViewController ()
@property (nonatomic, strong) CollectionOfElementsView *collenctionView;
@property (nonatomic, strong) ElementInfoTableViewController *elementsInfoTableViewController;
@end

@implementation CollectionOfElementsViewController

@synthesize collenctionView;

- (instancetype)initWithElements: (NSArray<ChemElement *> *)elements {
    if (self == [super initWithNibName:nil bundle:nil]) {
        [self setElementArray: elements];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    collenctionView = [[CollectionOfElementsView alloc] initWithFrame: [[UIScreen mainScreen] bounds] andElementsArray: [self elementArray]];
    [collenctionView setDelegate: self];
    [self setView: collenctionView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self addInfo];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    if (size.width < size.height) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)changeColor: (id)sender {
    NSDictionary *colorDictionary = @{@"Gas": @((6 - 6)/6.0), @"Metall": @((6 - 5)/6.0), @"Halbleiter": @((6 - 4)/6.0), @"Ferromagnetikum": @((6 - 3)/6.0), @"Halbmetall": @((6 - 2)/6.0), @"Flüssigkeit": @((6 - 1)/6.0), @"Flüssigkeit, Metall": @((6 - 0)/6.0)};
    UISegmentedControl *segmentedControl = sender;

    [_elementArray enumerateObjectsUsingBlock:^(ChemElement * _Nonnull element, NSUInteger idx, BOOL * _Nonnull stop) {

        CGFloat colorFloat = 0.0f;
        switch ([segmentedControl selectedSegmentIndex]) {
            case 0:
                colorFloat = element.atomMass/kMaxMass;
                break;
            case 1:
                colorFloat = [[colorDictionary objectForKey: element.phaseNorm] floatValue];
                break;
            case 2:
                colorFloat = [element.pauling floatValue]/kMaxPauling;
                break;

            default:
                break;
        }
        UIColor *cellColor = [UIColor colorWithHue:colorFloat saturation:0.8 brightness:0.7 alpha:1];

        [[[collenctionView buttonArray] objectAtIndex: idx] setBackgroundColor: cellColor];
    }];
    [collenctionView setNeedsDisplay];
}

- (void)elementButtonPressed: (UIButton *)sender {
    ChemElement *element = [[self elementArray] objectAtIndex: [sender tag]];
    [collenctionView.abkLabel setText: element.abbreviation];
    [collenctionView.ordinalLabel setText: [NSString stringWithFormat: @"%ld", element.ordinal]];

    [self.elementsInfoTableViewController setElement: element];
}

- (void)addInfo {
    ChemElement *element = self.elementArray[0];

    [collenctionView.abkLabel setText: element.abbreviation];
    [collenctionView.ordinalLabel setText: [NSString stringWithFormat: @"%ld", element.ordinal]];

    ElementInfoTableViewController *elementsInfoTableViewController = [[ElementInfoTableViewController alloc] initWithElement: element];
    [self addChildViewController: elementsInfoTableViewController];

    [self.view addSubview: elementsInfoTableViewController.view];
    CGRect frame = collenctionView.labelView.frame;
    frame.origin.x = frame.origin.x + 4;
    frame.origin.y = frame.origin.y + 4;
    frame.size.width = frame.size.width - 60;
    frame.size.height = frame.size.height - 8;
    elementsInfoTableViewController.view.frame = frame;

    self.elementsInfoTableViewController = elementsInfoTableViewController;
}

@end
