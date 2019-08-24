//  Created by dasdom on 24.08.19.
//  
//

import XCTest
@testable import Phy

class PhyTopicCellTests: XCTestCase {

  func test_update_setsText() {
    // given
    let sut = PhyTopicCell()
    let item = PhyTopic(title: "Foo", json: "foo")
    
    // when
    sut.update(with: item)
    
    // then
    XCTAssertEqual("Foo", sut.textLabel?.text)
  }
}
