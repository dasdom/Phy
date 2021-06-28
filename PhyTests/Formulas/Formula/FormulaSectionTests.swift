//  Created by dasdom on 04.08.19.
//  
//

import XCTest
@testable import Phy

class FormulaSectionTests: XCTestCase {
  
  func test_decode_whenTitleAndFormulas_decodes() {
    let formulaDict = ["imageName":"bar.png","title":"Bar"]
    let data = try! JSONSerialization.data(withJSONObject: ["title":"Foo","formulas":[formulaDict]], options: [])
    
    let result = try! JSONDecoder().decode(FormulaSection.self, from: data)
    
    let formula = Formula(imageName: "bar.png", title: "Bar")
    let expected = FormulaSection(title: "Foo", formulas: [formula])
    XCTAssertEqual(expected, result)
  }
  
}
