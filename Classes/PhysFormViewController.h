//
//  PhysFormViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 21.04.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhysFormViewController : UITableViewController <UISearchBarDelegate> {
	NSArray *tableDataSource;
	NSString *currentTitle;
	NSInteger currentLevel;
	NSInteger numberOfSections;
	NSArray *namesOfSections;
	NSMutableArray *listOfItems;
	
	NSArray *listOfAllItems;
	
	UISearchBar *searchBar;
	
	UIBarButtonItem *favorites;
	
	UIAlertView *formulaAlert;
	
	NSURL *iTunesURL;
}
@property (nonatomic, strong) NSArray *tableDataSource;
@property (nonatomic, strong) NSString *currentTitle;
@property (nonatomic, readwrite) NSInteger currentLevel;
@property (nonatomic, readwrite) NSInteger numberOfSections;
@property (nonatomic, strong) NSArray *namesOfSections;
@property (nonatomic, strong) NSMutableArray *listOfItems;

@property (nonatomic, strong) NSArray *listOfAllItems;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSURL *iTunesURL;

- (void)addButtonPressed;
- (void)addToFavorites;
- (void)formulaAdded: (NSString *)formulaName;
- (void)sendNotificationToCalc;

- (void)openReferralURL:(NSURL *)referralURL;

@end

