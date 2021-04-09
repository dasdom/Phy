//  Created by Dominik Hauser on 09/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class FormulasCoordinatorTests: XCTestCase {
  
  private var sut: FormulasCoordinator!
  private var navigationController: MockNavigationController!
  
  override func setUpWithError() throws {
    navigationController = MockNavigationController()
    sut = FormulasCoordinator(presenter: navigationController)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    navigationController = nil
  }
  
  func test_start_pushesViewController() throws {
    
    sut.start()
    
    let viewController = try XCTUnwrap(navigationController.topViewController)
    XCTAssertTrue(viewController is TopicViewController)
  }
  
  func test_start_setsDelegate() throws {
    
    sut.start()
    
    let topicViewController = try XCTUnwrap(navigationController.topViewController as? TopicViewController)
    XCTAssertEqual(topicViewController.delegate as? FormulasCoordinator, sut)
  }
  
  func test_topicSelected_pushesSpecialFields() throws {
    sut.start()
    let topicViewController = try XCTUnwrap(navigationController.topViewController as? TopicViewController)
    let topic = Topic(title: "Foo", json: "foo")
    
    sut.viewController(topicViewController, topicSelected: topic)
    
    XCTAssertTrue(navigationController.lastPushedViewController is SpecialFieldsViewController)
  }
}

extension FormulasCoordinator: Equatable {
  public static func == (lhs: FormulasCoordinator, rhs: FormulasCoordinator) -> Bool {
    return lhs === rhs
  }
}
