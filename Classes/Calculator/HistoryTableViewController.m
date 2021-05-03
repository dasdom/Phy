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

@interface HistoryTableViewController ()
@property (nonatomic, strong) NSArray *calcDictArray;
@end

@implementation HistoryTableViewController

- (instancetype)initWithHistoryArray:(NSArray *)historyArray {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _calcDictArray = historyArray;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *headerText = @"";
    if ([self isCalcHistory]) {
        [self setTitle: NSLocalizedString(@"Letzte Berechnungen", nil)];
        headerText = NSLocalizedString(@"Wähle die Rechnung aus, die in den Rechner eingefügt werden soll.", nil);
    } else {
        [self setTitle: NSLocalizedString(@"Letzte Ergebnisse", nil)];
        headerText = NSLocalizedString(@"Wähle das Ergebnis aus, das in den Rechner eingefügt werden soll.", nil);
    }
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.tableView.tableHeaderView = [self headerViewWithText:headerText];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIView *headerView = self.tableView.tableHeaderView;
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat headerWidth = headerView.bounds.size.width;
    NSLayoutConstraint *widthConstraint = [headerView.widthAnchor constraintEqualToConstant:headerWidth];
    
    widthConstraint.active = YES;
    
    [headerView setNeedsLayout];
    [headerView layoutIfNeeded];
    
    CGSize headerSize = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat height = headerSize.height;
    CGRect frame = headerView.frame;
    frame.size.height = height;
    headerView.frame = frame;
    
    self.tableView.tableHeaderView = headerView;
    
    widthConstraint.active = NO;
    headerView.translatesAutoresizingMaskIntoConstraints = YES;
}

- (UIView *)headerViewWithText:(NSString *)headerText {
    
    UIView *headerView = [[UIView alloc] init];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    headerLabel.numberOfLines = 0;
    headerLabel.text = headerText;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    [headerView addSubview:headerLabel];
    
    [NSLayoutConstraint activateConstraints:
     @[
       [headerLabel.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor constant:8],
       [headerLabel.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor constant:-8],
       [headerLabel.topAnchor constraintEqualToAnchor:headerView.topAnchor constant:8],
       [headerLabel.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:-8],
       ]];
    
    return headerView;
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
    
    NSDictionary *calcDict = self.calcDictArray[indexPath.row];

    NSString *stringToInsert = @"";
    if (self.isCalcHistory) {
        stringToInsert = calcDict[@"calcString"];
    } else {
        stringToInsert = [NSString stringWithFormat:@"%@", calcDict[@"solution"]];
    }
    
    [self.delegate insertString:stringToInsert];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
