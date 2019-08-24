//  Created by dasdom on 08.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaDetailViewControllerTests: XCTestCase {
  
  var sut: PhyFormulaDetailViewController!
  
  override func setUp() {
    sut = PhyFormulaDetailViewController(formula: formula())
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_loadingView_registersDetailCell() {
    // when
    sut.loadViewIfNeeded()
    
    // then
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: PhyFormulaDetailCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is PhyFormulaDetailCell)
  }
  
  func test_loadingView_registersDetailWithTextCell() {
    // when
    sut.loadViewIfNeeded()
    
    // then
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: PhyFormulaDetailWithTextCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is PhyFormulaDetailWithTextCell)
  }
  
  func test_numberOfSections() {
    // when
    let result = sut.numberOfSections(in: sut.tableView)
    
    // then
    XCTAssertEqual(formula().details?.count, result)
  }
  
  func test_numberOfRows() {
    // when
    let result = sut.tableView(sut.tableView, numberOfRowsInSection: 1)
    
    // then
    XCTAssertEqual(formula().details?[1].detailItems.count, result)
  }
  
  func test_cellForRow_whenFormula_dequeuesCell() {
    // given
    let mockTableView = TableViewMock<PhyFormulaDetailCell>()
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(mockTableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(mockTableView.dequeueReusableCellCalls, 1)
  }
  
  func test_cellForRow_whenAbbreviation_dequeuesCell() {
    // given
    let mockTableView = TableViewMock<PhyFormulaDetailWithTextCell>()
    
    // when
    let indexPath = IndexPath(row: 0, section: 1)
    _ = sut.tableView(mockTableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(mockTableView.dequeueReusableCellCalls, 1)
  }
  
  func test_titleForSection_1() {
    // when
    let result = sut.tableView(sut.tableView, titleForHeaderInSection: 0)
    
    // then
    XCTAssertEqual(formula().details?[0].title, result)
  }
  
  func test_titleForSection_2() {
    // when
    let result = sut.tableView(sut.tableView, titleForHeaderInSection: 1)
    
    // then
    XCTAssertEqual(formula().details?[1].title, result)
  }
  
  func test_cellForRow_callsUpdateWithFormulaDetail() {
    // given
    sut.tableView.register(MockFormulaDetailCell.self, forCellReuseIdentifier: PhyFormulaDetailCell.identifier)
    
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let mockCell = cell as! MockFormulaDetailCell
    XCTAssertEqual(formula().details?[0].detailItems[0], mockCell.lastItem)
  }
  
  func test_cellForRow_callsUpdateWithFormulaDetailWithText() {
    // given
    sut.tableView.register(MockFormulaDetailWithTextCell.self, forCellReuseIdentifier: PhyFormulaDetailWithTextCell.identifier)
    
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
    
    // then
    let mockCell = cell as! MockFormulaDetailWithTextCell
    XCTAssertEqual(formula().details?[1].detailItems[0], mockCell.lastItem)
  }
  
  func test_didSelectRow_whenPossible_showsSolver() {
    // given
    let detailItem = PhyFormulaDetailItem(imageName: "arbeit", title: "Arbeit", inputs: [SolverInput(id: "a", imageName: "a_colon", placeholder: "a")], results: [SolverResult(formula: "a", imageName: "a", imageNameShort: nil)])
    let detail = PhyFormulaDetail(title: "Foo", detailItems: [detailItem])
    let formula = PhyFormula(imageName: "arbeit", title: "Arbeit", details: [detail])
    sut = PhyFormulaDetailViewController(formula: formula)
    let navController = MockNavigationController(rootViewController: sut)
    navController.lastPushedViewController = nil
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let result = navController.lastPushedViewController as! SolverDetailViewController
    let expected = SolverTool(title: "Arbeit", imageName: "arbeit", inputs: [SolverInput(id: "a", imageName: "a_colon", placeholder: "a")], results: [SolverResult(formula: "a", imageName: "a", imageNameShort: nil)])
    XCTAssertEqual(result.tool, expected)
  }
}

// MARK: - Helper
extension PhyFormulaDetailViewControllerTests {
  
  func formula() -> PhyFormula {
    
    let formulasDetail = PhyFormulaDetail(title: "Foo", detailItems: [PhyFormulaDetailItem(imageName: "bar")])
    let abbreveationDetail = PhyFormulaDetail(title: "Abbreveation", detailItems: [PhyFormulaDetailItem(imageName: "bar_abk", title: "BarAbk"),PhyFormulaDetailItem(imageName: "baz_abk", title: "BazAbk")])
    
    return PhyFormula(imageName: "foo", title: "Foo", details: [formulasDetail, abbreveationDetail])
  }
  
  class TableViewMock<T> : UITableView where T: UITableViewCell {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return T.init()
    }
  }
  
  class MockFormulaDetailCell : PhyFormulaDetailCell {
    
    var lastItem: PhyFormulaDetailItem? = nil
    
    override func update(with item: PhyFormulaDetailItem) {
      lastItem = item
    }
  }
  
  class MockFormulaDetailWithTextCell : PhyFormulaDetailWithTextCell {
    
    var lastItem: PhyFormulaDetailItem? = nil
    
    override func update(with item: PhyFormulaDetailItem) {
      lastItem = item
    }
  }
}
