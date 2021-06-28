//  Created by Dominik Hauser on 28/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Phy

extension ConstantsListView: Inspectable {}

class ConstantsListViewTest: XCTestCase {

  func test_selectingConstant_callsDelegate() throws {
    var sut = ConstantsListView()
    let delegateMock = DelegateMock()
    sut.delegate = delegateMock

    try sut.inspect().list().find(ViewType.Button.self).tap()

    XCTAssertEqual(delegateMock.insertedString, "9.80665")
  }

}

class DelegateMock: NSObject, InsertStringProtocol {

  var insertedString: String? = nil

  func insertString(_ string: String) {
    self.insertedString = string
  }
}
