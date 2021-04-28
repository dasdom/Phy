//  Created by dasdom on 05.08.19.
//  
//

import XCTest
@testable import Phy

class FormulasViewControllerTests: XCTestCase {
  
  var sut: FormulasViewController!
  var dataSourceMock: FormulasDataSourceProtocolMock!
  var delegateMock: FormulasViewControllerProtocolMock!
  
  override func setUp() {
    dataSourceMock = FormulasDataSourceProtocolMock()
    sut = FormulasViewController(dataSource: dataSourceMock)
    delegateMock = FormulasViewControllerProtocolMock()
    sut.delegate = delegateMock
  }
  
  override func tearDown() {
    sut = nil
    dataSourceMock = nil
    delegateMock = nil
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
    dataSourceMock.formulaForReturnValue = Formula(imageName: "bar", title: "Bar")
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(mockTableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(mockTableView.dequeueReusableCellCalls, 1)
  }
  
  func test_numberOfSections_returnsValueFromDataSource() {
    // given
    dataSourceMock.numberOfSectionsReturnValue = 23
    
    // when
    let numberOfSections = sut.numberOfSections(in: sut.tableView)
    
    // then
    XCTAssertEqual(numberOfSections, 23)
  }
  
  func test_numberOfRows_returnsValueFromDataSource() {
    // given
    dataSourceMock.numberOfRowsInReturnValue = 42
    
    // when
    let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
    
    // then
    XCTAssertEqual(numberOfRows, 42)
  }
  
  func test_viewForHeaderInSection_returnsTitleFromDataSource() {
    // given
    dataSourceMock.titleForSectionReturnValue = "Foo"
    
    // when
    let title = sut.tableView(sut.tableView, titleForHeaderInSection: 0)
    
    // then
    XCTAssertEqual(title, "Foo")
  }
  
  func test_cellForRow_callsUpdateWithFormula() throws {
    // given
    let formula = Formula(imageName: "bar", title: "Bar")
    dataSourceMock.formulaForReturnValue = formula
    sut.tableView.register(MockFormulaCell.self, forCellReuseIdentifier: FormulaCell.identifier)
    
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let mockCell = try XCTUnwrap(cell as? MockFormulaCell)
    XCTAssertEqual(mockCell.lastFormula, formula)
  }
  
  func test_didSelectCell_callDelegate() throws {
    // given
    let formula = Formula(imageName: "arbeit", title: "Arbeit", details: [
      FormulaDetail(title: "Arbeit", detailItems: [FormulaDetailItem(imageName: "arbeit")])
    ])
    dataSourceMock.formulaForReturnValue = formula
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    XCTAssertEqual(delegateMock.formulaSelectedFormulaReceivedArguments?.1, formula)
  }
}

// MARK: - Mocks
extension FormulasViewControllerTests {
  class TableViewMock : UITableView {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return FormulaCell()
    }
  }
  
  class MockFormulaCell : FormulaCell {
    
    var lastFormula: Formula? = nil
    
    func update(with item: Formula) {
      self.lastFormula = item
    }
  }
}
