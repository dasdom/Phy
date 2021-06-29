//  Created by Dominik Hauser on 29/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
import ViewInspector
@testable import Phy

extension DescriptionImageView: Inspectable {}

class DescriptionImageViewTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_hasImage() throws {
    let sut = DescriptionImageView(item: FormulaDetailItem(imageName: "mechanics_friction_force"))

    let imageName = try sut.inspect().image().actualImage().name()

    XCTAssertEqual(imageName, "mechanics_friction_force")
  }
}
