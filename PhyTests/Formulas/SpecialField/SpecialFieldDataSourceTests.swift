//  Created by dasdom on 05.08.19.
//  
//

import XCTest
@testable import Phy

class SpecialFieldDataSourceTests: XCTestCase {
  
  var sut: SpecialFieldDataSource!
  
  override func setUp() {
    let specialFieldSections = [
      SpecialFieldSection(title: "Foo", specialFields: [SpecialField(title: "bla", formulaSections: []),
                                                        SpecialField(title: "blubb", formulaSections: []),
                                                        SpecialField(title: "blubber", formulaSections: [])]),
      SpecialFieldSection(title: "Bar", specialFields: []),
    ]
    sut = SpecialFieldDataSource(specialFieldSections: specialFieldSections)
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
    XCTAssertEqual(3, sut.numberOfRows(in: 0))
  }
  
  func test_init_generatesSpecialFieldsArray_3() {
    // then
    let firstSpecialField = sut.specialField(for: IndexPath(row: 0, section: 0))
    XCTAssertEqual("bla", firstSpecialField.title)
  }
}
