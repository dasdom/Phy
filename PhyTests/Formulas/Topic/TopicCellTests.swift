//  Created by dasdom on 24.08.19.
//  
//

import XCTest
@testable import Phy

class TopicCellTests: XCTestCase {

  func test_update_setsText() {
    // given
    let sut = TopicCell()
    let item = Topic(title: "Foo", type: .physics_formulas)
    
    // when
    sut.update(with: item)
    
    // then
    XCTAssertEqual("Foo", sut.textLabel?.text)
  }
}
