//  Created by Dominik Hauser on 28/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest

class CalculatorUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_calculator_whenConstantIsSelected_shouldAddConstant() {
    
    let app = XCUIApplication()
    app.launch()
    
    app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()

    let expectedValues = [
      "Gravitationsbeschleunigung, 9.80665 m s⁻²",
      "magnetische Feldkonstante, 𝜋×4e-7 V s A⁻¹ m⁻¹",
      "Rydberg-Konstante, 1.0973731568549e7 m⁻¹"
    ]
    
    expectedValues.forEach { string in
      
      app.buttons["const"].tap()
      
      sleep(1)
      let cell = app.cells[string]
      cell.tap()
      
      app.buttons["="].tap()
    }
  }
}
