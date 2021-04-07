//  Created by dasdom on 24.08.19.
//  
//

import XCTest
@testable import Phy

class ChemElementTests: XCTestCase {

  func test_decode() {
    // given
    let dict: [String : Any] = [
      "abbreviation": "H",
      "atomMass": 1.00794,
      "chemieBool": true,
      "electronConfiguration": "1s¹",
      "group": "Hauptgr. I",
      "name": "Wasserstoff",
      "ordinal": 1,
      "period": 1,
      "yPos": 1,
      "title": "1   Wasserstoff",
      "pauling": "2.2",
      "mostImportantRadioactiveIsotope": 3,
      "decayType": "ß⁻",
      "lifetime": "12.3 a",
      "phaseNorm": "Gas",
      "crystalStructure": "hexagonal"
      ]
    let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
    
    // when
    let result = try! JSONDecoder().decode(ChemElement.self, from: data)
    
    // then
    let expected = ChemElement(abbreviation: "H",
                               atomMass: 1.00794,
                               chemieBool: true,
                               electronConfiguration: "1s¹",
                               group: "Hauptgr. I",
                               name: "Wasserstoff",
                               ordinal: 1,
                               period: 1,
                               yPos: 1,
                               title: "1   Wasserstoff",
                               pauling: "2.2",
                               mostImportantRadioactiveIsotope: 3,
                               decayType: "ß⁻",
                               lifetime: "12.3 a",
                               phaseNorm: "Gas",
                               crystalStructure: "hexagonal")
    XCTAssertEqual(expected, result)
  }
}
