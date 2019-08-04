//  Created by dasdom on 03.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaDetailTests: XCTestCase {

    func test_decode_whenImageNameAndTitle_decodes() {
        let data = try! JSONSerialization.data(withJSONObject: ["title":"Foo","detailItems":[["imageName":"bar.png"]]], options: [])
        
        let result = try! JSONDecoder().decode(PhyFormulaDetail.self, from: data)
        
        let detailItem = PhyFormulaDetailItem(imageName: "bar.png")
        let expected = PhyFormulaDetail(title: "Foo", detailItems: [detailItem])
        XCTAssertEqual(expected, result)
    }

}
