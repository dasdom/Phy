//  Created by dasdom on 15.09.19.
//  
//

import XCTest
@testable import Phy

class ChemElementCellTests: XCTestCase {
  
  func test_update_setsText() {
    let sut = ChemElementCell()
    let item = ChemElement(abbreviation: "a",
                           atomMass: 1,
                           chemieBool: true,
                           electronConfiguration: "b",
                           group: "c",
                           name: "d",
                           ordinal: 2,
                           period: 3,
                           yPos: 4,
                           title: "Foo",
                           pauling: "f",
                           mostImportantRadioactiveIsotope: 5,
                           decayType: "g",
                           lifetime: "h",
                           phaseNorm: "i",
                           crystalStructure: "j")
    
    sut.update(with: item)
    
    XCTAssertEqual(sut.abbreviationLabel.text, "a")
    XCTAssertEqual(sut.ordinalLabel.text, "2")
    XCTAssertEqual(sut.nameLabel.text, "d")
    XCTAssertEqual(sut.massLabel.text, "1.0")
    XCTAssertEqual(sut.electronConfigurationLabel.text, "b")
  }
}
