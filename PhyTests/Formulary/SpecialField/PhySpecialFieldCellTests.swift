//  Created by dasdom on 05.08.19.
//  
//

import XCTest
@testable import Phy

class PhySpecialFieldCellTests: XCTestCase {
  
  func test_update_setsText() {
    // given
    let sut = PhySpecialFieldCell()
    let specialField = PhySpecialField(title: "Foo", formulaSections: [])
    
    // when
    sut.update(with: specialField)
    
    // then
    XCTAssertEqual("Foo", sut.textLabel?.text)
  }
  
}
