//  Created by Dominik Hauser on 09/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Phy

class AppCoordinatorTests: XCTestCase {
  
  private var sut: AppCoordinator!
  private var window: UIWindow!
  
  override func setUpWithError() throws {
    window = UIWindow(frame: UIScreen.main.bounds)
    sut = AppCoordinator(window: window)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    window = nil
  }
  
  func test_start_setsFormulasToTabBarController() throws {
    sut.start()
    
    let tabBarController = try XCTUnwrap(window.rootViewController as? UITabBarController)
    let navigationController = try XCTUnwrap(tabBarController.viewControllers?.first as? UINavigationController)
    let result = navigationController.topViewController
    
    XCTAssertTrue(result is TopicViewController)
  }
  
//  func test_start_setsCalculatorToTabBarController() throws {
//    sut.start()
//
//    let tabBarController = try XCTUnwrap(window.rootViewController as? UITabBarController)
//    let result = try XCTUnwrap(tabBarController.viewControllers?[1])
//
//    XCTAssertTrue(result is CalculatorViewController)
//  }
  
  func test_start_setsFavoritesToTabBarController() throws {
    sut.start()
    
    let tabBarController = try XCTUnwrap(window.rootViewController as? UITabBarController)
    let navigationController = try XCTUnwrap(tabBarController.viewControllers?[2] as? UINavigationController)
    let result = try XCTUnwrap(navigationController.topViewController as? FavoritesViewController)

    XCTAssertNotNil(result.delegate)
  }
  
  func test_start_setsSolverToTabBarController() throws {
    sut.start()
    
    let tabBarController = try XCTUnwrap(window.rootViewController as? UITabBarController)
    let navigationController = try XCTUnwrap(tabBarController.viewControllers?[3] as? UINavigationController)
    let result = navigationController.topViewController

    XCTAssertTrue(result is SolverTableViewController)
  }
}
