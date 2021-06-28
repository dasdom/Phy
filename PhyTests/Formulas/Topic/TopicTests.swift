//  Created by dasdom on 23.08.19.
//  
//

import XCTest
@testable import Phy

class TopicTests: XCTestCase {

  func test_decode() {
    let topicDict = ["title": "Foo", "json": "json", "type": "formulas"]
    let data = try! JSONSerialization.data(withJSONObject: topicDict, options: [])
    
    let result = try! JSONDecoder().decode(Topic.self, from: data)
    
    let expected = Topic(title: "Foo", json: "json", type: .formulas)
    XCTAssertEqual(expected, result)
  }

}
