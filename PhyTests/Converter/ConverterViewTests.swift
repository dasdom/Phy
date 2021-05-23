//  Created by Dominik Hauser on 23/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import Phy

extension ConverterView: Inspectable {}
extension ValueUnitView: Inspectable {}
extension NumberButtonsView: Inspectable {}
extension ActionRowView: Inspectable {}
extension ModifierButtonsView: Inspectable {}

class ConverterViewTests: XCTestCase {
  
  var converter: Converter!
  var sut: ConverterView!
  
  override func setUpWithError() throws {
    let units = [Phy.Unit(unit: "bla", value: "1"), Phy.Unit(unit: "blub", value: "2")]
    let converterInfo = ConvertInfo(id: 1, fieldName: "Foobar", units: units)
    converter = Converter(convertInfo: converterInfo)
    sut = ConverterView(converter: converter)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_hasInputText() throws {
    
    let string = try textWith(index: 0, inViewOfType: ValueUnitView.self, withIndex: 0)
    
    XCTAssertEqual(string, "Input:")
  }
  
  func test_showsInputValue() throws {
    
    converter.input = "5"
    
    let string = try textWith(index: 1, inViewOfType: ValueUnitView.self, withIndex: 0)
    
    XCTAssertEqual(string, "5")
  }
  
  func test_hasOutputText() throws {
    
    let string = try textWith(index: 0, inViewOfType: ValueUnitView.self, withIndex: 1)
    
    XCTAssertEqual(string, "Output:")
  }
  
  func test_showsOutputValue() throws {
    
    converter.output = "42"
    
    let string = try textWith(index: 1, inViewOfType: ValueUnitView.self, withIndex: 1)
    
    XCTAssertEqual(string, "42")
  }
  
  func test_hasActionRow() throws {
    let actionRow = try sut.inspect().find(ActionRowView.self).actualView()
    
    XCTAssertEqual(actionRow.converter, converter)
  }
  
  func test_hasNumberButtons() throws {
    let numberButtonsView = try sut.inspect().find(NumberButtonsView.self).actualView()
    
    XCTAssertEqual(numberButtonsView.converter, converter)
  }
  
  func test_hasModifierButtons() throws {
    let modifierButtonsView = try sut.inspect().find(ModifierButtonsView.self).actualView()
    
    XCTAssertEqual(modifierButtonsView.converter, converter)
  }
}

extension ConverterViewTests {
  func textWith<V>(index: Int, inViewOfType viewType: V.Type, withIndex viewIndex: Int) throws -> String where V : Inspectable {
    let views = try sut.inspect().findAll(viewType)
    XCTAssertGreaterThan(views.count, viewIndex)
    let view = views[viewIndex]
    let texts = view.findAll(ViewType.Text.self)
    XCTAssertGreaterThan(texts.count, index)
    return try texts[index].string()
  }
}

