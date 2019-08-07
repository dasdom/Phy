//  Created by dasdom on 05.08.19.
//  
//

import XCTest
@testable import Phy

class PhySpecialFieldDataSourceTests: XCTestCase {
  
  var sut: PhySpecialFieldDataSource!
  
  override func setUp() {
    sut = PhySpecialFieldDataSource()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_init_generatesSpecialFieldsArray_1() {
    // then
    XCTAssertEqual(9, sut.numberOfRows)
  }
  
  func test_init_generatesSpecialFieldsArray_2() {
    // then
    let firstSpecialField = sut.specialField(for: IndexPath(row: 0, section: 0))
    XCTAssertEqual("Mechanik", firstSpecialField.title)
  }
}
