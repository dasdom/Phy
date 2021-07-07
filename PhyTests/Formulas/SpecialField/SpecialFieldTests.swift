//  Created by dasdom on 04.08.19.
//  
//

import XCTest
@testable import Phy

class SpecialFieldTests: XCTestCase {

    func test_decode_whenTitleAndFormulaSections_decodes() {
        let formulaDict = ["id": "4E7CE952-D3EC-4CC8-8F59-617CD80E1176", "imageName":"baz.png","title":"Baz"]
      let formulaSectionDict: [String:Any] = ["id":"D025F919-B107-4F3D-8128-982D5F96ADBC","title":"Bar","formulas":[formulaDict]]
        let specialFieldDict: [String:Any] = ["title":"Foo","formulaSections":[formulaSectionDict]]
        let data = try! JSONSerialization.data(withJSONObject: specialFieldDict, options: [])

        let result = try! JSONDecoder().decode(SpecialField.self, from: data)

        let formula = Formula(id: UUID(uuidString: "4E7CE952-D3EC-4CC8-8F59-617CD80E1176")!, imageName: "baz.png", title: "Baz")
      let formulaSection = FormulaSection(id: UUID(uuidString: "D025F919-B107-4F3D-8128-982D5F96ADBC")!, title: "Bar", formulas: [formula])
        let expected = SpecialField(title: "Foo", formulaSections: [formulaSection])
        XCTAssertEqual(expected, result)
    }

}
