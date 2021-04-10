//  Created by dasdom on 03.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaDetailItemTests: XCTestCase {
    
    func test_decode_whenImageNameAndTitleIsSet_decodes() {
        let data = try! JSONSerialization.data(withJSONObject: ["imageName":"foo.png","title":"Foo"], options: [])
        
        let result = try! JSONDecoder().decode(FormulaDetailItem.self, from: data)
        
        let expected = FormulaDetailItem(imageName: "foo.png", title: "Foo")
        XCTAssertEqual(expected, result)
    }
    
    func test_decode_whenOnlyImageNameIsSet_decodes() {
        let data = try! JSONSerialization.data(withJSONObject: ["imageName":"foo.png"], options: [])
        
        let result = try! JSONDecoder().decode(FormulaDetailItem.self, from: data)
        
        let expected = FormulaDetailItem(imageName: "foo.png")
        XCTAssertEqual(expected, result)
    }
    
    func test_decode_whenImageNameAndInputAndOutputIsSet_decodes() {
        let inputsDict = [["id": "s","imageName": "s_colon","placeholder": "s"]]
        let resultsDict = [["formula": "#s÷#t","imageName": "v_equals"]]
        let data = try! JSONSerialization.data(withJSONObject: ["imageName":"foo.png","inputs":inputsDict,"results":resultsDict], options: [])
        
        let result = try! JSONDecoder().decode(FormulaDetailItem.self, from: data)
        
        let input = SolverInput(id: "s", imageName: "s_colon", placeholder: "s")
        let soverResult = SolverResult(formula: "#s÷#t", imageName: "v_equals", imageNameShort: nil)
        let expected = FormulaDetailItem(imageName: "foo.png", inputs: [input], results: [soverResult])
        XCTAssertEqual(expected, result)
    }
}
