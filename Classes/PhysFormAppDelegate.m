//  Created by Dominik Hauser on 21.04.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "PhysFormAppDelegate.h"
#import "GeneralCalculatorViewController.h"
#import "ConverterViewController.h"
#import "ReferenzViewController.h"
#import "Phy-Swift.h"

@implementation PhysFormAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  // MARK: Formulas
  UIViewController *viewController = [[PhyTopicViewController alloc] initWithStyle:UITableViewStyleGrouped];
  viewController.title = NSLocalizedString(@"Formeln", nil);
  
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
  navigationController.navigationBar.translucent = false;
  navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Formeln", nil) image:[UIImage imageNamed:@"list"] tag:0];
  
  // MARK: Calculator
  GeneralCalculatorViewController *generalCalculatorViewController = [[GeneralCalculatorViewController alloc] init];
  generalCalculatorViewController.title = NSLocalizedString(@"Rechner", nil);
  generalCalculatorViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Rechner", nil) image:[UIImage imageNamed:@"calculator"] tag:1];
  
  // MARK: Converter
  ConverterViewController *converterViewController = [[ConverterViewController alloc] init];
  converterViewController.title = NSLocalizedString(@"Konverter", nil);
  converterViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Konverter", nil) image:[UIImage imageNamed:@"converter"] tag:2];
  
  // MART: Reference
  ReferenzViewController *referenzViewController = [[ReferenzViewController alloc] init];
  referenzViewController.title = NSLocalizedString(@"Referenz", nil);
  referenzViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Referenz", nil) image:[UIImage imageNamed:@"reference"] tag:3];
  
  // MARK: Toos
  SolverTableViewController *solverTableViewController = [[SolverTableViewController alloc] init];
  solverTableViewController.title = NSLocalizedString(@"Werkzeuge", comment: "");
  solverTableViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Werkzeuge", nil) image:[UIImage imageNamed:@"tool"] tag:4];
  
  UINavigationController *solverNavigationController = [[UINavigationController alloc] initWithRootViewController:solverTableViewController];
  
  UITabBarController *tabBarController = [[UITabBarController alloc] init];
  
  tabBarController.viewControllers = @[navigationController,
                                       generalCalculatorViewController,
                                       converterViewController,
                                       referenzViewController,
                                       solverNavigationController
                                       ];
  
  self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
  self.window.rootViewController = tabBarController;
  
  [self.window makeKeyAndVisible];
  NSLog(@"finished loading");
  
  return true;
}

@end
