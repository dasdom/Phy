//  Created by Dominik Hauser on 28/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import Phy

class ConstantsListViewTest: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_constantsListView_snapshotTest() {
    let view = ConstantsListView()
    assertSnapshot(matching: view, as: .image)
  }
  
}
