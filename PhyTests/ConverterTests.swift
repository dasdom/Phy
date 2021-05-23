//  Created by Dominik Hauser on 22/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy
import Combine

class ConverterTests: XCTestCase {
  
  var sut: Converter!
  
  override func setUpWithError() throws {
    sut = Converter(convertInfo: ConvertInfo(id: 1, fieldName: "Foobar", units: [Phy.Unit(unit: "bla", value: "1"), Phy.Unit(unit: "blub", value: "2")]))
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_changingInput_changesOutput() throws {
    
    let result = try _awaitPublishedChange(sut.$output, changeAction: { sut.input = "5" })
    
    XCTAssertEqual(result, "2.5")
  }
}

// https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/
extension XCTestCase {
  func _await<T: Publisher>(
    _ publisher: T,
    timeout: TimeInterval = 10,
    file: StaticString = #file,
    line: UInt = #line
  ) throws -> T.Output {
    
    var result: Result<T.Output, Error>?
    let expectation = self.expectation(description: "Awaiting publisher")
    
    let cancellable = publisher.sink(
      receiveCompletion: { completion in
        switch completion {
          case .failure(let error):
            result = .failure(error)
          case .finished:
            break
        }
        
        expectation.fulfill()
      },
      receiveValue: { value in
        result = .success(value)
      }
    )
    
    waitForExpectations(timeout: timeout)
    cancellable.cancel()
    
    let unwrappedResult = try XCTUnwrap(
      result,
      "Awaited publisher did not produce any output",
      file: file,
      line: line
    )
    
    return try unwrappedResult.get()
  }
  
  func _awaitPublishedChange<T: Publisher>(
    _ publisher: T,
    changeAction: () -> Void = {},
    timeout: TimeInterval = 10,
    file: StaticString = #file,
    line: UInt = #line
  ) throws -> T.Output where T.Failure == Never {
    
    var result: Result<T.Output, Error>?
    let expectation = self.expectation(description: "Awaiting publisher")
    
    let cancellable = publisher
      .dropFirst()
      .sink(receiveValue: { value in
        result = .success(value)
        expectation.fulfill()
      })
    
    changeAction()
    waitForExpectations(timeout: timeout)
    cancellable.cancel()
    
    let unwrappedResult = try XCTUnwrap(
      result,
      "Awaited publisher did not produce any output",
      file: file,
      line: line
    )
    
    return try unwrappedResult.get()
  }
}
