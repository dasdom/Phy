//
//  HistoryTableViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorViewController;

@interface HistoryTableViewController : UITableViewController

@property (nonatomic, unsafe_unretained) CalculatorViewController *delegate;
@property (nonatomic) BOOL isCalcHistory;

- (instancetype)initWithHistoryArray:(NSArray *)historyArray;
@end
