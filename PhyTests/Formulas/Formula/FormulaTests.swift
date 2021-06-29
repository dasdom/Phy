//  Created by dasdom on 03.08.19.
//  
//

import XCTest
@testable import Phy

class FormulaTests: XCTestCase {
  
  func test_decode_whenImageNameAndTitle_decodes() {
    let data = try! JSONSerialization.data(withJSONObject: ["id": "4E7CE952-D3EC-4CC8-8F59-617CD80E1176", "imageName":"foo.png","title":"Foo"], options: [])
    
    let result = try! JSONDecoder().decode(Formula.self, from: data)
    
    let expected = Formula(id: UUID(uuidString: "4E7CE952-D3EC-4CC8-8F59-617CD80E1176")!, imageName: "foo.png", title: "Foo", details: nil)
    XCTAssertEqual(expected, result)
  }
  
  func test_decode_whenImageNameAndTitleAndDetails_decodes() {
    let detailDict = ["title":"Bar","detailItems":[["imageName":"baz.png"]]] as [String : Any];
    let data = try! JSONSerialization.data(withJSONObject: ["id": "4E7CE952-D3EC-4CC8-8F59-617CD80E1176", "imageName":"foo.png","title":"Foo","details":[detailDict]], options: [])
    
    let result = try! JSONDecoder().decode(Formula.self, from: data)
    
    let detailItem = FormulaDetailItem(imageName: "baz.png")
    let detail = FormulaDetail(title: "Bar", detailItems: [detailItem])
    let expected = Formula(id: UUID(uuidString: "4E7CE952-D3EC-4CC8-8F59-617CD80E1176")!, imageName: "foo.png", title: "Foo", details: [detail])
    XCTAssertEqual(expected, result)
  }
}
