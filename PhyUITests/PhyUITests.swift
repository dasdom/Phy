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
  
  func test_screenshots() {

    let app = XCUIApplication()

    app.launch()

    XCUIDevice.shared.orientation = .landscapeRight
    XCUIDevice.shared.orientation = .portrait

    sleep(1)

    app.tables.firstMatch.cells.element(boundBy: 0).tap()
    
    takeScreenshot(named: "1_special_fields")

    app.tables.firstMatch.cells.element(boundBy: 4).tap()
    
    takeScreenshot(named: "2_special_field")

    var button = app.navigationBars.buttons.firstMatch
    if button.exists {
      button.tap()
    }

    app.tables.firstMatch.cells.element(boundBy: 0).tap()

    if XCUIDevice.shared.supportsPointerInteraction {
      app.collectionViews.firstMatch.cells.element(boundBy: 11).tap()
    } else {
      app.collectionViews.firstMatch.cells.element(boundBy: 9).tap()
    }

    takeScreenshot(named: "3_formula")

    app.tables.firstMatch.cells.element(boundBy: 1).tap()

    app.textFields.element(boundBy: 0).typeText("5")

    let textField = app.textFields.element(boundBy: 2)
    textField.tap()
    textField.typeText("0.3")

    app.buttons["Calculate"].tap()

    takeScreenshot(named: "4_formula_calculator")

    app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()

    button = app.navigationBars.buttons.firstMatch
    if button.exists {
      button.tap()
    }

    app.tables.firstMatch.cells.element(boundBy: 0).tap()

    let calcString = "1.442e4"
    calcString.forEach { character in
      let string = String(character)
      app.buttons[string].tap()
    }
    
    takeScreenshot(named: "5_converter")

    app.tabBars.firstMatch.buttons.element(boundBy: 0).tap()
    app.tabBars.firstMatch.buttons.element(boundBy: 0).tap()

    app.tables.firstMatch.cells.element(boundBy: 2).tap()

    takeScreenshot(named: "6_chemistry_list")

    app.tables.firstMatch.cells.element(boundBy: 7).tap()

    takeScreenshot(named: "7_chemistry_detail")

    XCUIDevice.shared.orientation = .landscapeRight

    sleep(1)

    takeScreenshot(named: "8_chemistry_landscape")

    XCUIDevice.shared.orientation = .portrait

    app.terminate()

    takeScreenshot(named: "9_widgets")

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
