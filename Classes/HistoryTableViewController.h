//
//  HistoryTableViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *calcDictArray;
@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic) BOOL isCalcHistory;

@end
