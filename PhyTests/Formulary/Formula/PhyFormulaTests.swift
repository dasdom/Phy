//  Created by dasdom on 03.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaTests: XCTestCase {

    func test_decode_whenImageNameAndTitle_decodes() {
        let data = try! JSONSerialization.data(withJSONObject: ["imageName":"foo.png","title":"Foo"], options: [])
        
        let result = try! JSONDecoder().decode(Formula.self, from: data)
        
        let expected = Formula(imageName: "foo.png", title: "Foo", details: nil)
        XCTAssertEqual(expected, result)
    }
    
    func test_decode_whenImageNameAndTitleAndDetails_decodes() {
        let detailDict = ["title":"Bar","detailItems":[["imageName":"baz.png"]]] as [String : Any];
        let data = try! JSONSerialization.data(withJSONObject: ["imageName":"foo.png","title":"Foo","details":[detailDict]], options: [])
        
        let result = try! JSONDecoder().decode(Formula.self, from: data)
        
        let detailItem = FormulaDetailItem(imageName: "baz.png")
        let detail = FormulaDetail(title: "Bar", detailItems: [detailItem])
        let expected = Formula(imageName: "foo.png", title: "Foo", details: [detail])
        XCTAssertEqual(expected, result)
    }
}
