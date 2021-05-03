//  Created by dasdom on 12.08.19.
//  
//

import XCTest
@testable import Phy

class SolverDetailViewControllerTests: XCTestCase {
  
  var sut: SolverDetailViewController!
  var window: UIWindow!
  
  override func setUp() {
    let solver = SolverTool(title: "Arbeit", imageName: "arbeit", inputs: [SolverInput(id: "a", imageName: "a", placeholder: "a"), SolverInput(id: "b", imageName: "b", placeholder: "b")], results: [SolverResult(formula: "#a+#b", imageName: "a", imageNameShort: nil), SolverResult(formula: "#a-#b", imageName: "a", imageNameShort: nil)])
    sut = SolverDetailViewController(tool: solver)
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = sut
    window.makeKeyAndVisible()
  }
  
  override func tearDown() {
    window = nil
    sut = nil
  }

//  // MARK: - Register cells
//  func test_loadingView_registersImageCell() {
//    // Act
//    sut.loadViewIfNeeded()
//
//    // Assert
//    let cell = sut.tableView.dequeueReusableCell(withIdentifier: SolverDetailImageCell.identifier, for: IndexPath(row: 0, section: 0))
//    XCTAssertNotNil(cell)
//    XCTAssertTrue(cell is SolverDetailImageCell)
//  }
//
//  func test_loadingView_registersInputCell() {
//    // Act
//    sut.loadViewIfNeeded()
//
//    // Assert
//    let cell = sut.tableView.dequeueReusableCell(withIdentifier: SolverDetailInputCell.identifier, for: IndexPath(row: 0, section: 0))
//    XCTAssertNotNil(cell)
//    XCTAssertTrue(cell is SolverDetailInputCell)
//  }
//
//  func test_loadingView_registersButtonCell() {
//    // Act
//    sut.loadViewIfNeeded()
//
//    // Assert
//    let cell = sut.tableView.dequeueReusableCell(withIdentifier: SolverDetailButtonCell.identifier, for: IndexPath(row: 0, section: 0))
//    XCTAssertNotNil(cell)
//    XCTAssertTrue(cell is SolverDetailButtonCell)
//  }
//
//  func test_loadingView_registersResultCell() {
//    // Act
//    sut.loadViewIfNeeded()
//
//    // Assert
//    let cell = sut.tableView.dequeueReusableCell(withIdentifier: SolverDetailResultCell.identifier, for: IndexPath(row: 0, section: 0))
//    XCTAssertNotNil(cell)
//    XCTAssertTrue(cell is SolverDetailResultCell)
//  }
  
  // MARK: - Numbers
  func test_numberOfSections() {
    // when
    let result = sut.tableView.numberOfSections
    
    // then
    XCTAssertEqual(4, result)
  }
  
  func test_numberOfRows_inSection0() {
    // when
    let result = sut.tableView.numberOfRows(inSection: 0)
    
    // then
    XCTAssertEqual(1, result)
  }
  
  func test_numberOfRows_inSection1() {
    // when
    let result = sut.tableView.numberOfRows(inSection: 1)
    
    // then
    XCTAssertEqual(sut.tool.inputs.count, result)
  }
  
  func test_numberOfRows_inSection2() {
    // when
    let result = sut.tableView.numberOfRows(inSection: 2)
    
    // then
    XCTAssertEqual(1, result)
  }
  
  func test_numberOfRows_inSection3() {
    // when
    let result = sut.tableView.numberOfRows(inSection: 3)
    
    // then
    XCTAssertEqual(sut.tool.results.count, result)
  }
  
//  // MARK: - Update cells
//  func test_cellForRow_callsUpdateOfImageCell() {
//    // given
//    sut.tableView.register(MockSolverDetailImageCell.self, forCellReuseIdentifier: SolverDetailImageCell.identifier)
//
//    // when
//    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
//
//    // then
//    let mockCell = cell as! MockSolverDetailImageCell
//    XCTAssertEqual(sut.tool, mockCell.lastItem)
//  }
//
//  func test_cellForRow_callsUpdateOfInputCell() {
//    // given
//    sut.tableView.register(MockSolverDetailInputCell.self, forCellReuseIdentifier: SolverDetailInputCell.identifier)
//
//    // when
//    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
//
//    // then
//    let mockCell = cell as! MockSolverDetailInputCell
//    XCTAssertEqual(sut.tool.inputs.first, mockCell.lastItem)
//  }
//
//  func test_cellForRow_callsUpdateOfResultCell() {
//    // given
//    sut.tableView.register(MockSolverDetailResultCell.self, forCellReuseIdentifier: SolverDetailResultCell.identifier)
//
//    // when
//    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 3))
//
//    // then
//    let mockCell = cell as! MockSolverDetailResultCell
//    XCTAssertEqual(sut.tool.results.first, mockCell.lastItem)
//  }

  // MARK: - cellForRow
  func test_cellForRow_setsImageInImageCell() {
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let imageCell = cell as! SolverDetailImageCell
    XCTAssertNotNil(imageCell.formulaImageView.image)
    XCTAssertTrue(imageCell.formulaImageView.isDescendant(of: imageCell.contentView))
  }
  
  func test_cellForRow_retunsInputCell() {
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
    
    // then
    XCTAssertTrue(cell is SolverDetailInputCell)
    let inputCell = cell as! SolverDetailInputCell
    XCTAssertTrue(inputCell.textField.isDescendant(of: inputCell.contentView))
    XCTAssertTrue(inputCell.abbreviationImageView.isDescendant(of: inputCell.contentView))
  }

  func test_cellForRow_retunsButtonCell() {
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 2))
    
    // then
    let buttonCell = cell as! SolverDetailButtonCell
    XCTAssertEqual(sut, buttonCell.button.allTargets.first)
    XCTAssertTrue(buttonCell.button.isDescendant(of: buttonCell.contentView))
  }
  
  func test_cellForRow_retunsResultCell() {
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 3))
    
    // then
    XCTAssertTrue(cell is SolverDetailResultCell)
    let resultCell = cell as! SolverDetailResultCell
    XCTAssertTrue(resultCell.resultLabel.isDescendant(of: resultCell.contentView))
    XCTAssertTrue(resultCell.resultImageView.isDescendant(of: resultCell.contentView))
  }
  
  // MARK: - calculate
  func test_calculate_setsResult() {
    // given
    let inputCell0 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as! SolverDetailInputCell
    _ = inputCell0.textField.delegate?.textField?(inputCell0.textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "42")

    let inputCell1 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 1)) as! SolverDetailInputCell
    _ = inputCell1.textField.delegate?.textField?(inputCell1.textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "23")
    
    // when
    sut.calculate()
    
    // then
    let resultCell0 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 3)) as! SolverDetailResultCell
    XCTAssertEqual("= 65", resultCell0.resultLabel.text)
    
    let resultCell1 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 3)) as! SolverDetailResultCell
    XCTAssertEqual("= 19", resultCell1.resultLabel.text)
  }
  
  func test_settingOnlyFirstInput_doesNotEnabledButton() {
    // when
    let inputCell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as! SolverDetailInputCell
    _ = inputCell.textField.delegate?.textField?(inputCell.textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "42")
    
    // then
     XCTAssertEqual(false, sut.buttonEnabled)
  }
  
  func test_settingOnlySecondInput_doesNotEnabledButton() {
    // when
    let inputCell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 1)) as! SolverDetailInputCell
    _ = inputCell.textField.delegate?.textField?(inputCell.textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "42")
    
    // then
    XCTAssertEqual(false, sut.buttonEnabled)
  }
  
  func test_settingAllInput_doesEnabledButton() {
    // when
    let inputCell0 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as! SolverDetailInputCell
    _ = inputCell0.textField.delegate?.textField?(inputCell0.textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "23")
    let inputCell1 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 1)) as! SolverDetailInputCell
    _ = inputCell1.textField.delegate?.textField?(inputCell1.textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "42")
    
    // then
    XCTAssertEqual(true, sut.buttonEnabled)
  }
}

//// MARK: - Mocks
//extension SolverDetailViewControllerTests {
//
//  class TableViewMock : UITableView {
//
//    var dequeueReusableCellCalls = 0
//
//    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
//
//      dequeueReusableCellCalls += 1
//
//      return SolverDetailImageCell()
//    }
//  }
//
//  class MockSolverDetailImageCell : SolverDetailImageCell {
//
//    var lastItem: SolverTool? = nil
//
//    override func update(with item: SolverTool) {
//      lastItem = item
//    }
//  }
//
//  class MockSolverDetailInputCell : SolverDetailInputCell {
//
//    var lastItem: SolverInput? = nil
//
//    override func update(with item: SolverInput) {
//      lastItem = item
//    }
//  }
//
//  class MockSolverDetailResultCell : SolverDetailResultCell {
//
//    var lastItem: SolverResult? = nil
//
//    override func update(with item: SolverResult) {
//      lastItem = item
//    }
//  }
//}
