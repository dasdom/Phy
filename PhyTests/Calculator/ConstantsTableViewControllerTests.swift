//  Created by Dominik Hauser on 24/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class ConstantsTableViewControllerTests: XCTestCase {
  
  var sut: ConstantsTableViewController!
  
  override func setUpWithError() throws {
    sut = ConstantsTableViewController()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_cellForRow0_shouldReturnConstantCellWithGravitationalConstant() throws {
    sut.loadViewIfNeeded()
    
    let cell = try  XCTUnwrap(sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ConstantCell)
    
    let label = try XCTUnwrap(cell.value(forKey: "valueLabel") as? UILabel)
    XCTAssertEqual(label.text, "9.80665 m s⁻²")
  }
  
  func test_cellForRow20_shouldReturnConstantCellWithRydbergConstant() throws {
    sut.loadViewIfNeeded()
    
    let cell = try  XCTUnwrap(sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 20, section: 0)) as? ConstantCell)
    
    let label = try XCTUnwrap(cell.value(forKey: "valueLabel") as? UILabel)
    XCTAssertEqual(label.text, "1.0973731568549e7 m⁻¹")
  }
  
  // just as long as I refactor this
  func test_cellForAllRows() throws {
    
    let expectedValues = [
      "9.80665 m s⁻²",
      "101325 Pa",
      "6.673e-11 m³ kg⁻¹ s⁻²",
      "-273.15 C",
      "22.413996 dm³ mol⁻¹",
      "8.314472 J K⁻¹ mol⁻¹",
      "6.02214199e23 mol⁻¹",
      "1.3806503e-23 J K⁻¹",
      "8.85418782e-12 A s V⁻¹ m⁻¹",
      "pi*4e-7 V s A⁻¹ m⁻¹",
      "2.99792458e8 m s⁻¹",
      "5.670400e-8 W m⁻² K⁻⁴",
      "6.62606876e-34 J s",
      "1.602176462e-19 C",
      "9.10938199e-31 kg",
      "1.67262158e-27 kg",
      "1.67492716e-27 kg",
      "2.426310215e-12 m",
      "1.054571596e-34 Js",
      "7.297352533e-3 ",
      "1.0973731568549e7 m⁻¹"
    ]
    
    for (index, value) in expectedValues.enumerated() {
      let indexPath = IndexPath(row: index, section: 0)
      let cell = try  XCTUnwrap(sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath) as? ConstantCell)
      let label = try XCTUnwrap(cell.value(forKey: "valueLabel") as? UILabel)
      XCTAssertEqual(label.text, value)
    }
  }
  
  func test_numberOfRows_shouldReturnSomething() {
    
    let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
    
    XCTAssertEqual(numberOfRows, 21)
  }
}
