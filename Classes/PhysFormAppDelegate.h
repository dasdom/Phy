//
//  PhysFormAppDelegate.h
//  PhysForm
//
//  Created by Dominik Hauser on 21.04.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralCalculatorViewController.h"
#import "ConverterViewController.h"
#import "FavoritesViewController.h"
#import "ReferenzViewController.h"

@class DetailFormula;
//@class PhysFormViewController;

@interface PhysFormAppDelegate : NSObject <UIApplicationDelegate> {
//    UIWindow *window;
//    PhysFormViewController *viewController;
//  UINavigationController *navigationController;
//
//  UITabBarController *tabBarController;
//
//  GeneralCalculatorViewController *generalCalculatorViewController;
//  ConverterViewController *converterViewController;
//
//  FavoritesViewController *favoritesViewController;
//
//  ReferenzViewController *referenzViewController;
//
//  NSDictionary *data;
//
//  NSMutableArray *formulaArray;
}

@property (nonatomic, strong) UIWindow *window;
//@property (nonatomic, strong) PhysFormViewController *viewController;
@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, strong) NSMutableArray *formulaArray;

- (void)copyDatabaseIfNeeded;
- (NSString *)getDBPath;
- (void)removeDetailFormula: (DetailFormula *)detailFormulaObj;
- (void)addDetailFormula: (DetailFormula *)detailFormulaObj;

@end

