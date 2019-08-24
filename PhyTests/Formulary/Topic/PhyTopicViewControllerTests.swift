//  Created by dasdom on 23.08.19.
//  
//

import XCTest
@testable import Phy

class PhyTopicViewControllerTests: XCTestCase {

  var sut: PhyTopicViewController!
  
  override func setUp() {
    sut = PhyTopicViewController()
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_loadingView_registersCell() {
    // when
    sut.loadViewIfNeeded()
    
    // then
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: PhyTopicCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is PhyTopicCell)
  }
  
  func test_numberOfSections() {
    // given
    let mockNumberOfSections = 23
    let mockDataSource = MockTopicDataSource(numberOfSections: mockNumberOfSections)
    sut.topicDataSource = mockDataSource
    
    // when
    let result = sut.tableView.numberOfSections
    
    // then
    XCTAssertEqual(mockNumberOfSections, result)
  }
  
  func test_numberOfRows() {
    // given
    let mockNumberOfRows = 42
    let mockDataSource = MockTopicDataSource(numberOfRows: mockNumberOfRows)
    sut.topicDataSource = mockDataSource
    
    // when
    let result = sut.tableView.numberOfRows(inSection: 0)
    
    // then
    XCTAssertEqual(mockNumberOfRows, result)
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
  
  func test_cellForRow_callsTopicOfDataSource() {
    // given
    let topic = PhyTopic(title: "Foo", json: "foo")
    let mockDataSource = MockTopicDataSource(topicToReturn: topic)
    sut.topicDataSource = mockDataSource
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(indexPath, mockDataSource.lastIndexPath)
  }
  
  func test_cellForRow_callsUpdateOfCell() {
    // given
    let topic = PhyTopic(title: "Foo", json: "foo")
    let mockDataSource = MockTopicDataSource(topicToReturn: topic)
    sut.topicDataSource = mockDataSource
    sut.tableView.register(MockTopicCell.self, forCellReuseIdentifier: PhyTopicCell.identifier)

    // when
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    guard let mockCell = cell as? MockTopicCell else { fatalError() }
    XCTAssertEqual(topic, mockCell.lastItem)
  }
  
  func test_didSelectCell_pushesSpecialFieldViewController() {
    // given
    let topic = PhyTopic(title: "Foo", json: "data_physics")
    let mockDataSource = MockTopicDataSource(topicToReturn: topic)
    sut.topicDataSource = mockDataSource
    let navController = MockNavigationController(rootViewController: sut)
    navController.lastPushedViewController = nil
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let result = navController.lastPushedViewController as! PhySpecialFieldsViewController
    XCTAssertEqual(2, result.specialFieldDataSource.numberOfSections())
  }
}

extension PhyTopicViewControllerTests {
  
  class TableViewMock : UITableView {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return PhyTopicCell()
    }
  }
  
  class MockTopicDataSource : PhyTopicDataSourceProtocol {
    
    let _numberOfSections: Int
    let _numberOfRows: Int
    let _topicToReturn: PhyTopic
    var lastIndexPath: IndexPath? = nil
    
    init(numberOfSections: Int = 1, numberOfRows: Int = 0, topicToReturn: PhyTopic = PhyTopic(title: "Foo", json: "foo")) {
      self._numberOfSections = numberOfSections
      self._numberOfRows = numberOfRows
      self._topicToReturn = topicToReturn
    }
    
    func numberOfSections() -> Int {
      return _numberOfSections
    }
    
    func numberOfRows(in: Int) -> Int {
      return _numberOfRows
    }
    
    func topic(for indexPath: IndexPath) -> PhyTopic {
      
      lastIndexPath = indexPath
      
      return _topicToReturn
    }
  }
  
  class MockTopicCell : PhyTopicCell {
    
    var lastItem: PhyTopic?
    
    override func update(with item: PhyTopic) {
      lastItem = item
    }
  }
}
