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
    _ = try sut.inspect().find(text: "Energy")
  }
  
  func test_converterView_shouldBeContainedInNavigationLink() throws {
    _ = try sut.inspect().find(ConverterView.self).parent().navigationLink()
  }
}
