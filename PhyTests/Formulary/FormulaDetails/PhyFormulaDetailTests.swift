//  Created by dasdom on 03.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaDetailTests: XCTestCase {

    func test_decode_whenImageNameAndTitle_decodes() {
        let data = try! JSONSerialization.data(withJSONObject: ["title":"Foo","detailItems":[["imageName":"bar.png"]]], options: [])
        
        let result = try! JSONDecoder().decode(FormulaDetail.self, from: data)
        
        let detailItem = FormulaDetailItem(imageName: "bar.png")
        let expected = FormulaDetail(title: "Foo", detailItems: [detailItem])
        XCTAssertEqual(expected, result)
    }

}
