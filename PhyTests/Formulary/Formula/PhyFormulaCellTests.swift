//  Created by dasdom on 06.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaCellTests: XCTestCase {
  
  func test_update_setsText() {
    // given
    let sut = FormulaCell()
    let formula = Formula(imageName: "arbeit", title: "Bar")
    
    // when
    sut.update(with: formula)
    
    // then
    XCTAssertEqual("Bar", sut.nameLabel.text)
    XCTAssertNotNil(sut.formulaImageView.image)
  }
}
