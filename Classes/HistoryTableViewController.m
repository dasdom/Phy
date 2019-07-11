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

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        _calcDictArray = [[NSArray alloc] init];
    }
    return self;
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
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"zurück", nil) style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.calcDictArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryTableViewCell *cell = [HistoryTableViewCell cellForTableView: tableView];
    
    NSDictionary *calcDict = self.calcDictArray[indexPath.row];
    
    cell.calcStringTextView.text = calcDict[@"calcString"];
    cell.solutionLabel.text = [NSString stringWithFormat:@"= %@", calcDict[@"solution"]];

    if ([self isCalcHistory]) {
        [[cell calcStringTextView] setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [[cell solutionLabel] setFont:[UIFont systemFontOfSize:14.0f]];
    } else {
        [[cell calcStringTextView] setFont:[UIFont systemFontOfSize:14.0f]];
        [[cell solutionLabel] setFont:[UIFont boldSystemFontOfSize:14.0f]];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableString *mutableString;
    
    NSDictionary *calcDict = self.calcDictArray[indexPath.row];

    if (self.isCalcHistory) {
        mutableString = [[NSMutableString alloc] initWithFormat:@"%@_", calcDict[@"calcString"]];
    } else {
        NSArray *components = [self.delegate.calcString componentsSeparatedByString:@"_"];
        mutableString = [[NSMutableString alloc] initWithFormat:@"%@%@_", components.firstObject, calcDict[@"solution"]];
        [mutableString appendString:components.lastObject];
    }

    self.delegate.calcString = mutableString;
    self.delegate.calcStringView.text = self.delegate.calcString;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
