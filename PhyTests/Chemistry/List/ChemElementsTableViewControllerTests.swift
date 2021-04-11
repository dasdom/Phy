//  Created by dasdom on 25.08.19.
//  
//

import XCTest
@testable import Phy

class ChemElementsTableViewControllerTests: XCTestCase {

  var sut: ChemElementsTableViewController!
  var mockDataSource: MockElementsDataSource!
  
  override func setUp() {
    mockDataSource = MockElementsDataSource(numberOfSections: 23, numberOfRows: 42)
    sut = ChemElementsTableViewController(style: .plain, dataSource: mockDataSource)
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_loadingView_registersCell() {
    // Act
    sut.loadViewIfNeeded()
    
    // Assert
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: ChemElementCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is ChemElementCell)
  }
  
  func test_numberOfSections() {
    // when
    let result = sut.tableView.numberOfSections
    
    // then
    XCTAssertEqual(mockDataSource.numberOfSections(), result)
  }
  
  func test_numberOfRows() {
    // when
    let result = sut.tableView.numberOfRows(inSection: 0)
    
    // then
    XCTAssertEqual(mockDataSource.numberOfRows(in: 0), result)
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
  
  func test_cellForRow_callsElementOfDataSource() {
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(indexPath, mockDataSource.lastIndexPath)
  }
  
  func test_cellForRow_callsUpdateOfCell() {
    sut.tableView.register(MockElementCell.self, forCellReuseIdentifier: ChemElementCell.identifier)
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    guard let mockCell = cell as? MockElementCell else { fatalError() }
    XCTAssertEqual(mockDataSource._elementToReturn, mockCell.lastItem)
  }
  
  func test_didSelectCell_pushesChemElementDetailViewController() {
    let navController = MockNavigationController(rootViewController: sut)
    navController.lastPushedViewController = nil
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let result = navController.lastPushedViewController as! ChemElementDetailViewController
    XCTAssertEqual(mockDataSource._elementToReturn, result.element)
  }
}

// MARK: - Mocks
extension ChemElementsTableViewControllerTests {
  class MockElementsDataSource : ChemElementsDataSourceProtocol {
    
    let _numberOfSections: Int
    let _numberOfRows: Int
    let _elementToReturn: ChemElement
    var lastIndexPath: IndexPath? = nil

    internal init(numberOfSections: Int = 1, numberOfRows: Int = 0, elementToReturn: ChemElement = ChemElement(abbreviation: "", atomMass: 0, chemieBool: true, electronConfiguration: "", group: "", name: "", ordinal: 0, period: 0, yPos: 0, title: "", pauling: "", mostImportantRadioactiveIsotope: 0, decayType: "", lifetime: "", phaseNorm: "", crystalStructure: "")) {
      self._numberOfSections = numberOfSections
      self._numberOfRows = numberOfRows
      self._elementToReturn = elementToReturn
    }
    
    func numberOfSections() -> Int {
      return _numberOfSections
    }
    
    func numberOfRows(in: Int) -> Int {
      return _numberOfRows
    }
    
    func element(for indexPath: IndexPath) -> ChemElement {

      lastIndexPath = indexPath

      return _elementToReturn
    }
  }
  
  class TableViewMock : UITableView {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return ChemElementCell()
    }
  }
  
  class MockElementCell : ChemElementCell {
    
    var lastItem: ChemElement?
    
    override func update(with item: ChemElement) {
      lastItem = item
    }
  }
}
