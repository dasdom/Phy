//  Created by dasdom on 10.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaDetailCellTests: XCTestCase {

  func test_update_setsImage() {
    // given
    let sut = PhyFormulaDetailCell()
    let detailItem = PhyFormulaDetailItem(imageName: "arbeit")
    
    // when
    sut.update(with: detailItem)
    
    // then
    XCTAssertNotNil(sut.detailImageView.image)
  }
}
