//  Created by dasdom on 10.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaDetailWithTextCellTests: XCTestCase {

  func test_update_setsImageAndTitle() {
    // given
    let sut = FormulaDetailWithTextCell()
    let detailItem = FormulaDetailItem(imageName: "arbeit", title: "Foobar")
    
    // when
    sut.update(with: detailItem)
    
    // then
    XCTAssertNotNil(sut.detailImageView.image)
    XCTAssertEqual(detailItem.title, sut.nameLabel.text)
  }
}
