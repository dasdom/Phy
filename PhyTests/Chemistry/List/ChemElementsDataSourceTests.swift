//  Created by dasdom on 14.09.19.
//  
//

import XCTest
@testable import Phy

class ChemElementsDataSourceTests: XCTestCase {

  var sut: ChemElementsDataSource!
  
  override func setUp() {
    sut = ChemElementsDataSource(json: "data_elements")
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_init_resultsInOneSection() {
    XCTAssertEqual(sut.numberOfSections(), 1)
  }
  
  func test_init_resultsInMoreThan100Rows() {
    XCTAssertGreaterThanOrEqual(sut.numberOfRows(in: 0), 100)
  }
  
  func test_init_resultsInElementForIndexPath() {
    let firstElement = sut.element(for: IndexPath(row: 0, section: 0))
    XCTAssertEqual("H", firstElement.abbreviation)
  }
  
  func test_filterString_filtersElements() {
    switch language() {
      case .en:
        sut.filterString = "Oxygen"
      case .de:
        sut.filterString = "Sauerstoff"
    }
    let firstElement = sut.element(for: IndexPath(row: 0, section: 0))
    XCTAssertEqual("O", firstElement.abbreviation)
  }
}
