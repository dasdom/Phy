//  Created by Dominik Hauser on 28/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class CalculationGrouperTests: XCTestCase {
  
  var sut: CalculationGrouper!
  
  override func setUpWithError() throws {
    sut = CalculationGrouper()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_groups_whenNoParentheses_returnsEmptyArray() {
    let result = sut.group(string: "")
    
    XCTAssertEqual(result, [])
  }
  
  func test_groups_whenOnlyOpenParentheses_returnsEmptyArray() {
    let result = sut.group(string: "(")
    
    XCTAssertEqual(result, [])
  }
  
  func test_group_simple_1() {
    let input = "()"
    let result = sut.group(string: input)
    
    let nsRange = NSRange(location: 0, length: 1)
    XCTAssertEqual(result, [Range<String.Index>(nsRange, in: input)])
  }
  
  func test_group_simple_2() {
    let input = "(1)"
    let result = sut.group(string: input)
    
    let nsRange = NSRange(location: 0, length: 2)
    XCTAssertEqual(result, [Range<String.Index>(nsRange, in: input)])
  }
  
  func test_group_simple_3() {
    let input = "()()"
    let result = sut.group(string: input)
    
    let nsRanges = [
      Range<String.Index>(NSRange(location: 0, length: 1), in: input),
      Range<String.Index>(NSRange(location: 2, length: 1), in: input),
    ]
    
    XCTAssertEqual(result, nsRanges)
  }
  
  func test_group_simple_4() {
    let input = "(1)(2)"
    let result = sut.group(string: input)
    
    let nsRanges = [
      Range<String.Index>(NSRange(location: 0, length: 2), in: input),
      Range<String.Index>(NSRange(location: 3, length: 2), in: input),
    ]
    
    XCTAssertEqual(result, nsRanges)
  }
  
  func test_group_boxed_1() {
    let input = "(())"
    let result = sut.group(string: input)
    
    let nsRanges = [
      Range<String.Index>(NSRange(location: 1, length: 1), in: input),
      Range<String.Index>(NSRange(location: 0, length: 3), in: input),
    ]
    
    XCTAssertEqual(result, nsRanges)
  }
}
