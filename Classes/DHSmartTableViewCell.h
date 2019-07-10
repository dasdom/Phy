//
//  DHSmartTableViewCell.h
//  MeineAllergie
//
//  Created by Dominik Hauser on 10.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHSmartTableViewCell : UITableViewCell {}

+ (id)cellForTableView: (UITableView*)tableView;
+ (NSString*)cellIdentifier;

- (id)initWithCellIdentifier: (NSString*)cellID;

@end
