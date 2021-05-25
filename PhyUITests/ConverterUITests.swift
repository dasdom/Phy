//  Created by Dominik Hauser on 24/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest

class ConverterUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_inputValues_changesOutput() {
    let app = XCUIApplication()
    
    app.launch()
    
    app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
    
    app.tables.firstMatch.cells.element(boundBy: 0).tap()
    
    let calcString = "01.11e4"
    calcString.forEach { character in
      let string = String(character)
      app.buttons[string].tap()
    }
    
    let outputText = app.staticTexts["6.928838951e16"]
    
    XCTAssertTrue(outputText.exists)
  }
  
}
