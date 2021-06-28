//  Created by Dominik Hauser on 28/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class CalculatorTests: XCTestCase {
  
  var sut: Calculator!
  
  override func setUpWithError() throws {
    sut = Calculator()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_calculate_whenStringIsOne_returnsDigit() {
    let input = "1"
    let result = sut.calculate(input)
    
    XCTAssertEqual(result, input)
  }
  
  func test_calculate_whenStringIsNine_returnsDigit() {
    let input = "9"
    let result = sut.calculate(input)
    
    XCTAssertEqual(result, input)
  }
  
  func test_calculate_whenAddition() {
    let input = "1+1"
    let result = sut.calculate(input)
    
    XCTAssertEqual(result, "2")
  }
  
  func test_calculate_whenSubstraction() {
    let input = "2-1"
    let result = sut.calculate(input)

    XCTAssertEqual(result, "1")
  }
  
  func test_calculate_whenAdditionAndSubstruction_1() {
    let input = "1+2-1"
    let result = sut.calculate(input)
    
    XCTAssertEqual(result, "2")
  }
  
  func test_calculate_whenAdditionAndSubstruction_2() {
    let input = "2-1+3"
    let result = sut.calculate(input)
    
    XCTAssertEqual(result, "4")
  }
  
  func test_calculate_whenMultiplication() {
    let input = "2×3"
    let result = sut.calculate(input)
    
    XCTAssertEqual(result, "6")
  }
  
  func x_test_calculate_whenDivision() {
    let input = "6÷2"
    let result = sut.calculate(input)
    
    XCTAssertEqual(result, "3")
  }


}
