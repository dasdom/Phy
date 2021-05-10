//  Created by Dominik Hauser on 07/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class PhyUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_demo() {
    let app = XCUIApplication()
    
    app.launch()
    
    print("debug: \(app.debugDescription)")
  }
  
  func test_screenshots() {
    let app = XCUIApplication()
    
    app.launch()
    
    takeScreenshot(named: "start")
    
    app.tables.firstMatch.cells.element(boundBy: 0).tap()
    
    takeScreenshot(named: "special_fields")

    app.tables.firstMatch.cells.element(boundBy: 4).tap()
    
    takeScreenshot(named: "special_field")

    app.tables.firstMatch.cells.element(boundBy: 3).tap()
    
    takeScreenshot(named: "formula")

    app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()

    app.buttons["const"].tap()

    takeScreenshot(named: "calculator_constants")

    app.tables.firstMatch.cells.element(boundBy: 2).tap()

    var calcString: String = "×5.9723e24×455000÷400e3^2="
    calcString.forEach { character in
      let string = String(character)
      app.buttons[string].tap()
    }
    
    takeScreenshot(named: "calculator_result")

    app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()

    app.tables.firstMatch.cells.element(boundBy: 0).tap()

    calcString = "1.442e4"
    calcString.forEach { character in
      let string = String(character)
      app.buttons[string].tap()
    }
    
    takeScreenshot(named: "converter")
    
    app.tabBars.firstMatch.buttons.element(boundBy: 3).tap()
    
    takeScreenshot(named: "reference")

    app.tabBars.firstMatch.buttons.element(boundBy: 4).tap()
    
    app.tables.firstMatch.cells.element(boundBy: 0).tap()
    
    app.typeText("2")

    app.buttons["next"].firstMatch.tap()
    
    app.typeText("5")

    app.buttons["next"].firstMatch.tap()
    
    app.typeText("3")
    
    app.buttons["next"].firstMatch.tap()

    sleep(1)
    
    takeScreenshot(named: "tool")
    
    app.tabBars.firstMatch.buttons.element(boundBy: 0).tap()
    app.tabBars.firstMatch.buttons.element(boundBy: 0).tap()

    app.tables.firstMatch.cells.element(boundBy: 2).tap()

    app.tables.firstMatch.cells.element(boundBy: 7).tap()

    takeScreenshot(named: "chemistry")
  }
}

extension PhyUITests {
  func takeScreenshot(named name: String) {
    sleep(1)
    
    // Take the screenshot
    let fullScreenshot = XCUIScreen.main.screenshot()
    
    // Create a new attachment to save our screenshot
    // and give it a name consisting of the "named"
    // parameter and the device name, so we can find
    // it later.
    let screenshotAttachment = XCTAttachment(
      uniformTypeIdentifier: "public.png",
      name: "Screenshot-\(UIDevice.current.name)-\(name).png",
      payload: fullScreenshot.pngRepresentation,
      userInfo: nil)
    
    // Usually Xcode will delete attachments after
    // the test has run; we don't want that!
    screenshotAttachment.lifetime = .keepAlways
    
    // Add the attachment to the test log,
    // so we can retrieve it later
    add(screenshotAttachment)
  }
}
