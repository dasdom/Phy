//  Created by dasdom on 07.08.19.
//  
//

import XCTest
@testable import Phy

class FormulasDataSourceTests: XCTestCase {

  func test_numberOfSections_1() {
    // given
    let sections = self.sections_1()
    let sut = FormulasDataSource(sections: sections)
    
    // when
    let numberOfSections = sut.numberOfSections()
    
    // then
    XCTAssertEqual(sections.count, numberOfSections)
  }
  
  func test_numberOfSections_2() {
    // given
    let sections = self.sections_2()
    let sut = FormulasDataSource(sections: sections)
    
    // when
    let numberOfSections = sut.numberOfSections()
    
    // then
    XCTAssertEqual(sections.count, numberOfSections)
  }
  
  func test_numberOfRows_1() {
    // given
    let sections = self.sections_2()
    let sut = FormulasDataSource(sections: sections)
    
    // when
    let numberOfRows = sut.numberOfRows(in: 0)
    
    // then
    XCTAssertEqual(sections.first?.formulas.count, numberOfRows)
  }
  
  func test_numberOfRows_2() {
    // given
    let sections = self.sections_2()
    let sut = FormulasDataSource(sections: sections)
    
    // when
    let numberOfRows = sut.numberOfRows(in: 1)
    
    // then
    XCTAssertEqual(sections.last?.formulas.count, numberOfRows)
  }
  
  func test_title() {
    // given
    let sections = self.sections_2()
    let sut = FormulasDataSource(sections: sections)
    
    // when
    let result = sut.titleFor(section: 1)
    
    // then
    XCTAssertEqual(sections.last?.title, result)
  }
  
  func test_formula() {
    // given
    let sections = self.sections_2()
    let sut = FormulasDataSource(sections: sections)
    
    // when
    let result = sut.formula(for: IndexPath(row: 0, section: 1))
    
    // then
    XCTAssertEqual(sections.last?.formulas.first, result)
  }
}

extension FormulasDataSourceTests {
  func sections_1() -> [FormulaSection] {
    return [
      FormulaSection(title: "Foo", formulas: [])
    ]
  }
  
  func sections_2() -> [FormulaSection] {
    return [
      FormulaSection(title: "Foo", formulas: [
        Formula(imageName: "bla", title: "Bla"),
        Formula(imageName: "blubb", title: "Blubb")
        ]),
      FormulaSection(title: "Bar", formulas: [
        Formula(imageName: "blubb", title: "Blubb")
        ])
    ]
  }
}
