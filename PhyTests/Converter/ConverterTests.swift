//  Created by Dominik Hauser on 22/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy
import Combine

class ConverterTests: XCTestCase {
  
  var sut: Converter!
  
  override func setUpWithError() throws {
    let units = [Phy.Unit(unit: "bla", value: "1"), Phy.Unit(unit: "blub", value: "2")]
    let convertInfo = ConvertInfo(id: 1, fieldName: "Foobar", units: units)
    sut = Converter(convertInfo: convertInfo)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_changingInput_changesOutput() throws {
    
    let result = try _awaitPublishedChange(sut.$output, changeAction: { sut.input = "5" })
    
    XCTAssertEqual(result, "2.5")
  }
}
