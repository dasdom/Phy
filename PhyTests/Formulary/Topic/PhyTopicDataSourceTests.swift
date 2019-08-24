//  Created by dasdom on 24.08.19.
//  
//

import XCTest
@testable import Phy

class PhyTopicDataSourceTests: XCTestCase {

  var sut: PhyTopicDataSource!
  
  override func setUp() {
    sut = PhyTopicDataSource()
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_init_resultsInCorrectNumberOfSections() {
    // then
    XCTAssertEqual(1, sut.numberOfSections())
  }
  
  func test_init_resultsInCorrectNumberOfRows() {
    // then
    XCTAssertEqual(2, sut.numberOfRows(in: 0))
  }
  
  func test_init_resultsInCorrectFirstItem() {
    // then
    let firstTopic = sut.topic(for: IndexPath(row: 0, section: 0))
    XCTAssertEqual("Physik", firstTopic.title)
  }
}
