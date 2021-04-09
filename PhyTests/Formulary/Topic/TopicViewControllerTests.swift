//  Created by dasdom on 23.08.19.
//  
//

import XCTest
@testable import Phy

class TopicViewControllerTests: XCTestCase {

  var sut: TopicViewController!
  var mockDataSource: MockTopicDataSource!
  private let mockNumberOfSections = 23
  private let mockNumberOfRows = 42
  private let topic = Topic(title: "Foo", json: "foo")
  
  override func setUp() {
    mockDataSource = MockTopicDataSource(numberOfSections: mockNumberOfSections, numberOfRows: mockNumberOfRows, topicToReturn: topic)
    sut = TopicViewController(dataSource: mockDataSource)
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_loadingView_registersCell() {
    // when
    sut.loadViewIfNeeded()
    
    // then
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: TopicCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is TopicCell)
  }
  
  func test_numberOfSections() {
    
    // when
    let result = sut.tableView.numberOfSections
    
    // then
    XCTAssertEqual(result, mockNumberOfSections)
  }
  
  func test_numberOfRows() {
   
    // when
    let result = sut.tableView.numberOfRows(inSection: 0)
    
    // then
    XCTAssertEqual(result, mockNumberOfRows)
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
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(mockDataSource.lastIndexPath, indexPath)
  }
  
  func test_cellForRow_callsUpdateOfCell() {
    // given
    sut.tableView.register(MockTopicCell.self, forCellReuseIdentifier: TopicCell.identifier)

    // when
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
    
    // then
    guard let mockCell = cell as? MockTopicCell else { fatalError() }
    XCTAssertEqual(mockCell.lastItem, topic)
  }
  
  func test_didSelectCell_pushesSpecialFieldViewController() {
    // given
    let topic = Topic(title: "Foo", json: "data_physics")
    let mockDataSource = MockTopicDataSource(topicToReturn: topic)
    sut = TopicViewController(dataSource: mockDataSource)

    let navController = MockNavigationController(rootViewController: sut)
    navController.lastPushedViewController = nil
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let result = navController.lastPushedViewController as! SpecialFieldsViewController
    XCTAssertEqual(2, result.specialFieldDataSource.numberOfSections())
  }
}

extension TopicViewControllerTests {
  
  class TableViewMock : UITableView {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return TopicCell()
    }
  }
  
  class MockTopicDataSource : TopicDataSourceProtocol {
    
    let _numberOfSections: Int
    let _numberOfRows: Int
    let _topicToReturn: Topic
    var lastIndexPath: IndexPath? = nil
    
    init(numberOfSections: Int = 1, numberOfRows: Int = 0, topicToReturn: Topic = Topic(title: "Foo", json: "foo")) {
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
    
    func topic(for indexPath: IndexPath) -> Topic {
      
      lastIndexPath = indexPath
      
      return _topicToReturn
    }
  }
  
  class MockTopicCell : TopicCell {
    
    var lastItem: Topic?
    
    override func update(with item: Topic) {
      lastItem = item
    }
  }
}
