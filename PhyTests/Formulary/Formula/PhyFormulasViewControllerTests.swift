//  Created by dasdom on 05.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulasViewControllerTests: XCTestCase {
  
  var dataSource: PhyFormulasDataSource!
  var sut: PhyFormulasViewController!
  
  override func setUp() {
    dataSource = PhyFormulasDataSource(sections: [PhyFormulaSection(title: "Foo", formulas: [PhyFormula(imageName: "bar", title: "Bar")])])
    sut = PhyFormulasViewController(dataSource: dataSource)
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_init_takesFormulasDataSource() {
    // given
    let formulasDataSource = PhyFormulasDataSource(sections: [])
    
    // when
    _ = PhyFormulasViewController(dataSource: formulasDataSource)
  }
  
  func test_loadingView_registersCell() {
    // Act
    sut.loadViewIfNeeded()
    
    // Assert
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: PhyFormulaCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is PhyFormulaCell)
  }
  
  func test_cellForRow_dequeuesCell() {
    // given
    let mockTableView = TableViewMock()
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(mockTableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(mockTableView.dequeueReusableCellCalls, 1)
  }
  
  func test_numberOfSections_returnsValueFromDataSource() {
    // given
    let mockDataSource = MockFormulaDataSource(numberOfSections: 23)
    sut = PhyFormulasViewController(dataSource: mockDataSource)
    
    // when
    let numberOfSections = sut.numberOfSections(in: sut.tableView)
    
    // then
    XCTAssertEqual(23, numberOfSections)
  }
  
  func test_numberOfRows_returnsValueFromDataSource() {
    // given
    let mockDataSource = MockFormulaDataSource(numberOfRows: 42)
    sut = PhyFormulasViewController(dataSource: mockDataSource)
    
    // when
    let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
    
    // then
    XCTAssertEqual(42, numberOfRows)
  }
  
  func test_titleForHeaderInSection_returnsTitleFromDataSource() {
    // given
    let mockDataSource = MockFormulaDataSource(title: "Foo")
    sut = PhyFormulasViewController(dataSource: mockDataSource)
    
    // when
    let title = sut.tableView(sut.tableView, titleForHeaderInSection: 0)
    
    // then
    XCTAssertEqual("Foo", title)
  }
  
  func test_cellForRow_callsUpdateWithFormula() {
    // given
    let formula = PhyFormula(imageName: "bar", title: "Bar")
    let mockDataSource = MockFormulaDataSource(formula: formula)
    sut = PhyFormulasViewController(dataSource: mockDataSource)
    sut.tableView.register(MockFormulaCell.self, forCellReuseIdentifier: PhyFormulaCell.identifier)
    
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let mockCell = cell as! MockFormulaCell
    XCTAssertEqual(formula, mockCell.lastFormula)
  }
}

// MARK: - Mocks
extension PhyFormulasViewControllerTests {
  class TableViewMock : UITableView {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return PhyFormulaCell()
    }
  }
  
  struct MockFormulaDataSource : PhyFormulasDataSourceProtocol {
    
    let _numberOfSections: Int
    let _numberOfRows: Int
    let _title: String
    let _formula: PhyFormula
    
    init(numberOfSections: Int = -1, numberOfRows: Int = -1, title: String = "", formula: PhyFormula = PhyFormula(imageName: "nöpe", title: "Nöpe")) {
      
      _numberOfSections = numberOfSections
      _numberOfRows = numberOfRows
      _title = title
      _formula = formula
    }
    
    func numberOfSections() -> Int {
      return _numberOfSections
    }
    
    func numberOfRows(in: Int) -> Int {
      return _numberOfRows
    }
    
    func titleFor(section: Int) -> String {
      return _title
    }
    
    func formula(for: IndexPath) -> PhyFormula {
      return _formula
    }
  }
  
  class MockFormulaCell : PhyFormulaCell {
    
    var lastFormula: PhyFormula? = nil
    
    override func update(with item: PhyFormula) {
      self.lastFormula = item
    }
  }
}
