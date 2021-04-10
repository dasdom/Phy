//  Created by dasdom on 04.08.19.
//  
//

import XCTest
@testable import Phy

class SpecialFieldsViewControllerTests: XCTestCase {
  
  var sut: SpecialFieldsViewController!
  var dataSourceMock: MockSpecialFieldDataSource!
  
  override func setUp() {
    dataSourceMock = MockSpecialFieldDataSource(numberOfSections: 23, numberOfRows: 42)
    sut = SpecialFieldsViewController(style: .plain, dataSource: dataSourceMock)
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_loadingView_registersCell() {
    // Act
    sut.loadViewIfNeeded()
    
    // Assert
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: SpecialFieldCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is SpecialFieldCell)
  }
  
  func test_cellForRow_dequeuesCell() {
    // given
    let mockTableView = TableViewMock()
    
    // when
    _ = sut.tableView(mockTableView, cellForRowAt: IndexPath(row: 0, section: 0))
    
    // then
    XCTAssertEqual(mockTableView.dequeueReusableCellCalls, 1)
  }
  
  func test_numberOfRows_returnsNumberOfDataSource() {
    // when
    let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
    
    // then
    XCTAssertEqual(42, numberOfRows)
  }
  
  func test_cellForRow_callsSpecialFieldOfDataSource() {
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    let mockSpecialFieldDataSource = sut.specialFieldDataSource as? MockSpecialFieldDataSource
    XCTAssertEqual(indexPath, mockSpecialFieldDataSource?.lastIndexPath)
  }

  func test_cellForRow_callsUpdateOfCell() {
    // given
    sut.tableView.register(MockSpecialFieldCell.self, forCellReuseIdentifier: SpecialFieldCell.identifier)
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    guard let mockCell = cell as? MockSpecialFieldCell else { fatalError() }
    let mockSpecialFieldDataSource = sut.specialFieldDataSource as? MockSpecialFieldDataSource
    XCTAssertEqual(mockSpecialFieldDataSource?.specialFieldToReturn, mockCell.lastItem)
  }
  
  func test_didSelectCell_callsDelegateWithSpecialField() {
    // given
    let stub = SpecialFieldsViewControllerProtocolStub()
    sut.delegate = stub
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let specialFieldMock = dataSourceMock.specialFieldToReturn
    XCTAssertEqual(stub.lastSelectedSpecialField, specialFieldMock)
  }
}

// MARK: - Mocks
extension SpecialFieldsViewControllerTests {
  class TableViewMock : UITableView {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return SpecialFieldCell()
    }
  }
  
  class MockSpecialFieldDataSource : SpecialFieldDataSourceProtocol {
    
    var lastIndexPath: IndexPath? = nil
    lazy var specialFieldToReturn = SpecialField(title: "Foo", formulaSections: [])
    let numberOfRows: Int
    let _numberOfSections: Int
    
    init(numberOfSections: Int = 0, numberOfRows: Int = 0) {
      self._numberOfSections = numberOfSections
      self.numberOfRows = numberOfRows
    }
    
    func numberOfSections() -> Int {
      return _numberOfSections
    }
    
    func numberOfRows(in: Int) -> Int {
      return numberOfRows
    }
    
    func specialField(for indexPath: IndexPath) -> SpecialField {
      
      lastIndexPath = indexPath
      
      return self.specialFieldToReturn
    }
  }
  
  class MockSpecialFieldCell : SpecialFieldCell {
    
    var lastItem: SpecialField?
    
    override func update(with item: SpecialField) {
      lastItem = item
    }
  }
}
