//  Created by dasdom on 21.08.19.
//  
//

import XCTest
@testable import Phy

class PhySpecialFieldSectionTests: XCTestCase {

  func test_decode_whenTitleAndSpecialFields() {
    let formulaDict = ["imageName":"baz.png","title":"Baz"]
    let formulaSectionDict: [String:Any] = ["title":"Bar","formulas":[formulaDict]]
    let specialFieldDict: [String:Any] = ["title":"Foo","formulaSections":[formulaSectionDict]]
    let specialFieldSectionDict = ["title":"Bla","specialFields":[specialFieldDict]] as [String : Any]
    let data = try! JSONSerialization.data(withJSONObject: specialFieldSectionDict, options: [])
    
    let result = try! JSONDecoder().decode(PhySpecialFieldSection.self, from: data)
    
    let formula = PhyFormula(imageName: "baz.png", title: "Baz")
    let formulaSection = PhyFormulaSection(title: "Bar", formulas: [formula])
    let specialField = PhySpecialField(title: "Foo", formulaSections: [formulaSection])
    let expected = PhySpecialFieldSection(title: "Bla", specialFields: [specialField])
    XCTAssertEqual(expected, result)
  }
}
