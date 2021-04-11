//  Created by Dominik Hauser on 11/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class ChemElementDetailViewControllerTests: XCTestCase {
  
  var sut: ChemElementDetailViewController!
  
  override func setUpWithError() throws {
    sut = ChemElementDetailViewController(element: element)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_numberOfRows() {
    
    let result = sut.tableView.numberOfRows(inSection: 0)
    
    let expected = ChemElementDetailViewController.Row.allCases.count
    XCTAssertEqual(result, expected)
  }
  
  func test_ordinalCell_isSetup() {
    let ordinal = ChemElementDetailViewController.Row.ordinal
    let row = ordinal.rawValue
    
    let indexPath = IndexPath(row: row, section: 0)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
    
    XCTAssertEqual(cell?.textLabel?.text, ordinal.name)
    XCTAssertEqual(cell?.detailTextLabel?.text, "\(element.ordinal)")
  }
}

extension ChemElementDetailViewControllerTests {
  var element: ChemElement {
    return ChemElement(abbreviation: "a",
                       atomMass: 1,
                       chemieBool: true,
                       electronConfiguration: "b",
                       group: "c",
                       name: "d",
                       ordinal: 2,
                       period: 3,
                       yPos: 4,
                       title: "Foo",
                       pauling: "f",
                       mostImportantRadioactiveIsotope: 5,
                       decayType: "g",
                       lifetime: "h",
                       phaseNorm: "i",
                       crystalStructure: "j")
  }
}
