//  Created by Dominik Hauser on 24/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import Phy

extension ConverterList: Inspectable {}

class ConverterListTests: XCTestCase {
  
  var sut: ConverterList!
  
  override func setUpWithError() throws {
    sut = ConverterList()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_textWithEnergy_shouldExist() throws {
    let searchText: String
    switch language() {
      case .en:
        searchText = "Energy"
      case .de:
        searchText = "Energie"
    }
    _ = try sut.inspect().find(text: searchText)
  }
  
  func test_converterView_shouldBeContainedInNavigationLink() throws {
    _ = try sut.inspect().find(ConverterView.self).parent().navigationLink()
  }

  func test_valueOfSecondEnergyConverter() throws {
    let searchText: String
    switch language() {
      case .en:
        searchText = "Energy"
      case .de:
        searchText = "Energie"
    }
    let link = try sut.inspect().find(navigationLink: searchText)

    let converterView = try link.view(ConverterView.self).actualView()
    XCTAssertEqual(converterView.converter.convertInfo.units[1].value, "1.602e-13")
  }
}
