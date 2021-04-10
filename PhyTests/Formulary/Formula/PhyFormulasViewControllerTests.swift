//  Created by dasdom on 05.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulasViewControllerTests: XCTestCase {
  
  var dataSource: FormulasDataSource!
  var sut: FormulasViewController!
  
  override func setUp() {
    dataSource = FormulasDataSource(sections: [FormulaSection(title: "Foo", formulas: [Formula(imageName: "bar", title: "Bar")])])
    sut = FormulasViewController(dataSource: dataSource)
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_init_takesFormulasDataSource() {
    // given
    let formulasDataSource = FormulasDataSource(sections: [])
    
    // when
    _ = FormulasViewController(dataSource: formulasDataSource)
  }
  
  func test_loadingView_registersCell() {
    // Act
    sut.loadViewIfNeeded()
    
    // Assert
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: FormulaCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is FormulaCell)
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
    sut = FormulasViewController(dataSource: mockDataSource)
    
    // when
    let numberOfSections = sut.numberOfSections(in: sut.tableView)
    
    // then
    XCTAssertEqual(23, numberOfSections)
  }
  
  func test_numberOfRows_returnsValueFromDataSource() {
    // given
    let mockDataSource = MockFormulaDataSource(numberOfRows: 42)
    sut = FormulasViewController(dataSource: mockDataSource)
    
    // when
    let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
    
    // then
    XCTAssertEqual(42, numberOfRows)
  }
  
  func test_viewForHeaderInSection_returnsTitleFromDataSource() {
    // given
    let mockDataSource = MockFormulaDataSource(title: "Foo")
    sut = FormulasViewController(dataSource: mockDataSource)
    
    // when
    let view = sut.tableView(sut.tableView, viewForHeaderInSection: 0)
    
    // then
    let lables = view?.subviews.filter({ view in
      if let label = view as? UILabel {
        return label.text == "Foo"
      }
      return false
    })
    XCTAssertEqual(1, lables?.count)
  }
  
  func test_cellForRow_callsUpdateWithFormula() {
    // given
    let formula = Formula(imageName: "bar", title: "Bar")
    let mockDataSource = MockFormulaDataSource(formula: formula)
    sut = FormulasViewController(dataSource: mockDataSource)
    sut.tableView.register(MockFormulaCell.self, forCellReuseIdentifier: FormulaCell.identifier)
    
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let mockCell = cell as! MockFormulaCell
    XCTAssertEqual(formula, mockCell.lastFormula)
  }
  
  func test_didSelectCell_pushesFormulasViewController() {
    // given
    let formula = Formula(imageName: "arbeit", title: "Arbeit", details: [
      FormulaDetail(title: "Arbeit", detailItems: [FormulaDetailItem(imageName: "arbeit")])
      ])
    let mockDataSource = MockFormulaDataSource(formula: formula)
    sut = FormulasViewController(dataSource: mockDataSource)
    let navController = MockNavigationController(rootViewController: sut)
    navController.lastPushedViewController = nil
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let result = navController.lastPushedViewController as! FormulaDetailViewController
    XCTAssertEqual(formula, result.formula)
  }
}

// MARK: - Mocks
extension PhyFormulasViewControllerTests {
  class TableViewMock : UITableView {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return FormulaCell()
    }
  }
  
  struct MockFormulaDataSource : FormulasDataSourceProtocol {
    
    let _numberOfSections: Int
    let _numberOfRows: Int
    let _title: String
    let _formula: Formula
    
    init(numberOfSections: Int = -1, numberOfRows: Int = -1, title: String = "", formula: Formula = Formula(imageName: "nöpe", title: "Nöpe")) {
      
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
    
    func formula(for: IndexPath) -> Formula {
      return _formula
    }
  }
  
  class MockFormulaCell : FormulaCell {
    
    var lastFormula: Formula? = nil
    
    override func update(with item: Formula) {
      self.lastFormula = item
    }
  }
}
