//  Created by dasdom on 04.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaSectionTests: XCTestCase {

    func test_decode_whenTitleAndFormulas_decodes() {
        let formulaDict = ["imageName":"bar.png","title":"Bar"]
        let data = try! JSONSerialization.data(withJSONObject: ["title":"Foo","formulas":[formulaDict]], options: [])
        
        let result = try! JSONDecoder().decode(PhyFormulaSection.self, from: data)
        
        let formula = PhyFormula(imageName: "bar.png", title: "Bar")
        let expected = PhyFormulaSection(title: "Foo", formulas: [formula])
        XCTAssertEqual(expected, result)
    }

}
