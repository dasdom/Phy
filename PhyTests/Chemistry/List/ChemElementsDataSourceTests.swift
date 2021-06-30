//  Created by dasdom on 14.09.19.
//  
//

import XCTest
@testable import Phy

class ChemElementsDataSourceTests: XCTestCase {

  var sut: ChemElementsDataSource!
  
  override func setUp() {
    sut = ChemElementsDataSource(elements: elements())
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_init_resultsInOneSection() {
    XCTAssertEqual(sut.numberOfSections(), 1)
  }
  
  func test_init_resultsInMoreThan100Rows() {
    XCTAssertEqual(sut.numberOfRows(in: 0), 2)
  }
  
  func test_init_resultsInElementForIndexPath() {
    let firstElement = sut.element(for: IndexPath(row: 0, section: 0))
    XCTAssertEqual("A", firstElement.abbreviation)
  }
  
  func test_filterString_filtersElements() {
    sut.filterString = "D"
    let firstElement = sut.element(for: IndexPath(row: 0, section: 0))
    XCTAssertEqual("A", firstElement.abbreviation)
  }
}

extension ChemElementsDataSourceTests {
  func elements() -> [ChemElement] {
    return [
      ChemElement(abbreviation: "A", atomMass: 1, chemieBool: true, electronConfiguration: "B", group: "C", name: "D", ordinal: 2, period: 3, yPos: 4, title: "E", pauling: "F", mostImportantRadioactiveIsotope: 5, decayType: "G", lifetime: "H", phaseNorm: "I", crystalStructure: "J"),
      ChemElement(abbreviation: "AA", atomMass: 11, chemieBool: true, electronConfiguration: "BB", group: "CC", name: "DD", ordinal: 22, period: 33, yPos: 44, title: "EE", pauling: "FF", mostImportantRadioactiveIsotope: 55, decayType: "GG", lifetime: "HH", phaseNorm: "II", crystalStructure: "JJ")
    ]
  }
}
