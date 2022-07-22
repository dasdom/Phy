//  Created by dasdom on 25.08.19.
//  
//

import XCTest
@testable import Phy

class ChemElementsTableViewControllerTests: XCTestCase {

  var sut: ChemElementsTableViewController!
  var dataSourceMock: ChemElementsDataSourceProtocolMock!
  
  override func setUp() {
    dataSourceMock = ChemElementsDataSourceProtocolMock()
    dataSourceMock.numberOfSectionsReturnValue = 23
    dataSourceMock.numberOfRowsInReturnValue = 42
    sut = ChemElementsTableViewController(style: .plain, dataSource: dataSourceMock)
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
    // given
    let numberOfSections = 23
    dataSourceMock.numberOfSectionsReturnValue = numberOfSections
    
    // when
    let result = sut.tableView.numberOfSections
    
    // then
    XCTAssertEqual(numberOfSections, result)
  }
  
  func test_numberOfRows() {
    let numberOfSections = 23
    dataSourceMock.numberOfSectionsReturnValue = numberOfSections
    let numberOfRows = 42
    dataSourceMock.numberOfRowsInReturnValue = numberOfRows
    
    // when
    let result = sut.tableView.numberOfRows(inSection: 0)
    
    // then
    XCTAssertEqual(result, numberOfRows)
  }
  
  func test_cellForRow_dequeuesCell() {
    // given
    let element = dummyElement()
    dataSourceMock.elementForReturnValue = element
    let mockTableView = TableViewMock()
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(mockTableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(mockTableView.dequeueReusableCellCalls, 1)
  }
  
  func test_cellForRow_callsElementOfDataSource() {
    let element = dummyElement()
    dataSourceMock.elementForReturnValue = element
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(indexPath, dataSourceMock.elementForReceivedIndexPath)
  }
  
  func test_cellForRow_callsUpdateOfCell() {
    let element = dummyElement()
    dataSourceMock.elementForReturnValue = element
    sut.tableView.register(MockElementCell.self, forCellReuseIdentifier: ChemElementCell.identifier)
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    guard let mockCell = cell as? MockElementCell else { fatalError() }
    XCTAssertEqual(mockCell.lastItem, element)
  }
  
  func test_didSelectCell_pushesChemElementDetailViewController() {
    let element = dummyElement()
    dataSourceMock.elementForReturnValue = element
    let navController = MockNavigationController(rootViewController: sut)
    navController.lastPushedViewController = nil
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let result = navController.lastPushedViewController as! ChemElementDetailViewController
    XCTAssertEqual(result.element, element)
  }
  
  func test_tableViewHeader_containsSearchBar() {
    let searchBar = sut.tableView.tableHeaderView as? UISearchBar
    XCTAssertNotNil(searchBar)
  }
  
  func test_searchBar_hasDelegate() throws {
    let searchBar = sut.tableView.tableHeaderView as? UISearchBar
    
    let delegate = try XCTUnwrap(searchBar?.delegate as? NSObject)
    XCTAssertEqual(delegate, sut)
  }
  
  func test_searchBarTextDidChange_filtersElements() throws {
    let searchBar = try XCTUnwrap(sut.tableView.tableHeaderView as? UISearchBar)

    searchBar.delegate?.searchBar?(searchBar, textDidChange: "a")
    
    XCTAssertEqual(dataSourceMock.filterString, "a")
  }
}

// MARK: - Mocks
extension ChemElementsTableViewControllerTests {
  func dummyElement() -> ChemElement {
    return ChemElement(abbreviation: "a", atomMass: 2.3, chemieBool: true, electronConfiguration: "b", group: "c", name: "d", ordinal: 42, period: 123, yPos: 21, title: "e", pauling: "f", mostImportantRadioactiveIsotope: 11, decayType: "g", lifetime: "h", phaseNorm: "i", crystalStructure: "j")
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
