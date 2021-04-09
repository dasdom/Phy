//  Created by dasdom on 05.08.19.
//  
//

import XCTest
@testable import Phy

class PhySpecialFieldDataSourceTests: XCTestCase {
  
  var sut: SpecialFieldDataSource!
  
  override func setUp() {
    sut = SpecialFieldDataSource(json: "data_physics")
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_init_generatesSpecialFieldsArray_1() {
    // then
    XCTAssertEqual(2, sut.numberOfSections())
  }
  
  func test_init_generatesSpecialFieldsArray_2() {
    // then
    XCTAssertEqual(9, sut.numberOfRows(in: 0))
  }
  
  func test_init_generatesSpecialFieldsArray_3() {
    // then
    let firstSpecialField = sut.specialField(for: IndexPath(row: 0, section: 0))
    XCTAssertEqual("Mechanik", firstSpecialField.title)
  }
}
