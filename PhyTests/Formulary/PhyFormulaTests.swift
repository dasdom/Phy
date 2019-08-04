//  Created by dasdom on 03.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaTests: XCTestCase {

    func test_decode_whenImageNameAndTitle_decodes() {
        let data = try! JSONSerialization.data(withJSONObject: ["imageName":"foo.png","title":"Foo"], options: [])
        
        let result = try! JSONDecoder().decode(PhyFormula.self, from: data)
        
        let expected = PhyFormula(imageName: "foo.png", title: "Foo", details: nil)
        XCTAssertEqual(expected, result)
    }
    
    func test_decode_whenImageNameAndTitleAndDetails_decodes() {
        let detailDict = ["title":"Bar","detailItems":[["imageName":"baz.png"]]] as [String : Any];
        let data = try! JSONSerialization.data(withJSONObject: ["imageName":"foo.png","title":"Foo","details":[detailDict]], options: [])
        
        let result = try! JSONDecoder().decode(PhyFormula.self, from: data)
        
        let detailItem = PhyFormulaDetailItem(imageName: "baz.png")
        let detail = PhyFormulaDetail(title: "Bar", detailItems: [detailItem])
        let expected = PhyFormula(imageName: "foo.png", title: "Foo", details: [detail])
        XCTAssertEqual(expected, result)
    }
}
