//  Created by dasdom on 04.08.19.
//  
//

import XCTest
@testable import Phy

class PhySpecialFieldsViewControllerTests: XCTestCase {
  
  var sut: PhySpecialFieldsViewController!
  
  override func setUp() {
    sut = PhySpecialFieldsViewController()
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_loadingView_registersCell() {
    // Act
    sut.loadViewIfNeeded()
    
    // Assert
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: PhySpecialFieldCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is PhySpecialFieldCell)
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
    // given
    let mockSpecialFieldDataSource = MockSpecialFieldDataSource(numberOfRows: 12)
    sut.specialFieldDataSource = mockSpecialFieldDataSource
    
    // when
    let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
    
    // then
    XCTAssertEqual(12, numberOfRows)
  }
  
  func test_cellForRow_callsSpecialFieldOfDataSource() {
    // given
    let mockSpecialFieldDataSource = MockSpecialFieldDataSource(numberOfRows: 0)
    sut.specialFieldDataSource = mockSpecialFieldDataSource
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(indexPath, mockSpecialFieldDataSource.lastIndexPath)
  }

  func test_cellForRow_callsUpdateOfCell() {
    // given
    let mockSpecialFieldDataSource = MockSpecialFieldDataSource(numberOfRows: 0)
    sut.specialFieldDataSource = mockSpecialFieldDataSource
    sut.tableView.register(MockSpecialFieldCell.self, forCellReuseIdentifier: PhySpecialFieldCell.identifier)
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    guard let mockCell = cell as? MockSpecialFieldCell else { fatalError() }
    XCTAssertEqual(mockSpecialFieldDataSource.specialFieldToReturn, mockCell.lastItem)
  }
  
  func test_didSelectCell_pushesFormulasViewController() {
    // given
    let mockSpecialFieldDataSource = MockSpecialFieldDataSource(numberOfRows: 1)
    let sections = [PhyFormulaSection(title: "Bar", formulas: [])]
    mockSpecialFieldDataSource.specialFieldToReturn = PhySpecialField(title: "Foobar", formulaSections: sections)
    sut.specialFieldDataSource = mockSpecialFieldDataSource
    let navController = MockNavigationController(rootViewController: sut)
    navController.lastPushedViewController = nil

    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let result = navController.lastPushedViewController as! PhyFormulasViewController
    XCTAssertEqual(sections.count, result.dataSource.numberOfSections())
  }
}

// MARK: - Mocks
extension PhySpecialFieldsViewControllerTests {
  class TableViewMock : UITableView {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return PhySpecialFieldCell()
    }
  }
  
  class MockSpecialFieldDataSource : PhySpecialFieldDataSourceProtocol {
    
    var lastIndexPath: IndexPath? = nil
    lazy var specialFieldToReturn = PhySpecialField(title: "Foo", formulaSections: [])
    let numberOfRows: Int
    
    init(numberOfRows: Int) {
      self.numberOfRows = numberOfRows
    }
    
    func specialField(for indexPath: IndexPath) -> PhySpecialField {
      
      lastIndexPath = indexPath
      
      return self.specialFieldToReturn
    }
  }
  
  class MockSpecialFieldCell : PhySpecialFieldCell {
    
    var lastItem: PhySpecialField?
    
    override func update(with item: PhySpecialField) {
      lastItem = item
    }
  }
  
  class MockNavigationController : UINavigationController {
    
    var lastPushedViewController: UIViewController? = nil
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      lastPushedViewController = viewController
      
      super.pushViewController(viewController, animated: true)
    }
  }
}
