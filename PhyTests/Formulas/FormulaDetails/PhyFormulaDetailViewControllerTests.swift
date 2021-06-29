//  Created by dasdom on 08.08.19.
//  
//

import XCTest
@testable import Phy

class PhyFormulaDetailViewControllerTests: XCTestCase {
  
  var sut: FormulaDetailViewController!
  
  override func setUp() {
    sut = FormulaDetailViewController(formula: formula())
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_loadingView_registersDetailCell() {
    // when
    sut.loadViewIfNeeded()
    
    // then
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: FormulaDetailCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is FormulaDetailCell)
  }
  
  func test_loadingView_registersDetailWithTextCell() {
    // when
    sut.loadViewIfNeeded()
    
    // then
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: FormulaDetailWithTextCell.identifier, for: IndexPath(row: 0, section: 0))
    XCTAssertNotNil(cell)
    XCTAssertTrue(cell is FormulaDetailWithTextCell)
  }
  
  func test_numberOfSections() {
    // when
    let result = sut.numberOfSections(in: sut.tableView)
    
    // then
    XCTAssertEqual(formula().details?.count, result)
  }
  
  func test_numberOfRows() {
    // when
    let result = sut.tableView(sut.tableView, numberOfRowsInSection: 1)
    
    // then
    XCTAssertEqual(formula().details?[1].detailItems.count, result)
  }
  
  func test_cellForRow_whenFormula_dequeuesCell() {
    // given
    let mockTableView = TableViewMock<FormulaDetailCell>()
    
    // when
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView(mockTableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(mockTableView.dequeueReusableCellCalls, 1)
  }
  
  func test_cellForRow_whenAbbreviation_dequeuesCell() {
    // given
    let mockTableView = TableViewMock<FormulaDetailWithTextCell>()
    
    // when
    let indexPath = IndexPath(row: 0, section: 1)
    _ = sut.tableView(mockTableView, cellForRowAt: indexPath)
    
    // then
    XCTAssertEqual(mockTableView.dequeueReusableCellCalls, 1)
  }
  
  func test_titleForSection_1() {
    // when
    let result = sut.tableView(sut.tableView, titleForHeaderInSection: 0)
    
    // then
    XCTAssertEqual(formula().details?[0].title, result)
  }
  
  func test_titleForSection_2() {
    // when
    let result = sut.tableView(sut.tableView, titleForHeaderInSection: 1)
    
    // then
    XCTAssertEqual(formula().details?[1].title, result)
  }
  
  func test_cellForRow_callsUpdateWithFormulaDetail() {
    // given
    sut.tableView.register(MockFormulaDetailCell.self, forCellReuseIdentifier: FormulaDetailCell.identifier)
    
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let mockCell = cell as! MockFormulaDetailCell
    XCTAssertEqual(formula().details?[0].detailItems[0], mockCell.lastItem)
  }
  
  func test_cellForRow_callsUpdateWithFormulaDetailWithText() {
    // given
    sut.tableView.register(MockFormulaDetailWithTextCell.self, forCellReuseIdentifier: FormulaDetailWithTextCell.identifier)
    
    // when
    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
    
    // then
    let mockCell = cell as! MockFormulaDetailWithTextCell
    XCTAssertEqual(formula().details?[1].detailItems[0], mockCell.lastItem)
  }
  
  func test_didSelectRow_whenPossible_showsSolver() {
    // given
    let detailItem = FormulaDetailItem(imageName: "arbeit", title: "Arbeit", inputs: [SolverInput(id: "a", imageName: "a_colon", placeholder: "a", inputType: nil)], results: [SolverResult(formula: "a", imageName: "a", imageNameShort: nil)])
    let detail = FormulaDetail(title: "Foo", detailItems: [detailItem])
    let formula = Formula(id: UUID(), imageName: "arbeit", title: "Arbeit", details: [detail])
    sut = FormulaDetailViewController(formula: formula)
    let navController = MockNavigationController(rootViewController: sut)
    navController.lastPushedViewController = nil
    
    // when
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // then
    let result = navController.lastPushedViewController as! SolverDetailViewController
    let expected = SolverTool(title: "Arbeit", imageName: "arbeit", inputs: [SolverInput(id: "a", imageName: "a_colon", placeholder: "a", inputType: nil)], results: [SolverResult(formula: "a", imageName: "a", imageNameShort: nil)])
    XCTAssertEqual(result.tool, expected)
  }

  func test_loadingView_shouldAddFavoritesButton() {
    sut.loadViewIfNeeded()

    let button = sut.navigationItem.rightBarButtonItem

    XCTAssertNotNil(button?.image)
  }

  func test_favButton_shouldCallDelegate() throws {
    sut.loadViewIfNeeded()
    let mockDelegate = FormulaDetailViewControllerDelegateMock()
    sut.delegate = mockDelegate

    let button = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
    tap(button)

    XCTAssertEqual(mockDelegate.favFormulaReceivedArguments?.formula, sut.formula)
  }
}

// MARK: - Helper
extension PhyFormulaDetailViewControllerTests {
  
  func formula() -> Formula {
    
    let formulasDetail = FormulaDetail(title: "Foo", detailItems: [FormulaDetailItem(imageName: "bar")])
    let abbreveationDetail = FormulaDetail(title: "Abbreveation", detailItems: [FormulaDetailItem(imageName: "bar_abk", title: "BarAbk"),FormulaDetailItem(imageName: "baz_abk", title: "BazAbk")])
    
    return Formula(id: UUID(), imageName: "foo", title: "Foo", details: [formulasDetail, abbreveationDetail])
  }
  
  class TableViewMock<T> : UITableView where T: UITableViewCell {
    
    var dequeueReusableCellCalls = 0
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueReusableCellCalls += 1
      
      return T.init()
    }
  }
  
  class MockFormulaDetailCell : FormulaDetailCell {
    
    var lastItem: FormulaDetailItem? = nil
    
    override func update(with item: FormulaDetailItem) {
      lastItem = item
    }
  }
  
  class MockFormulaDetailWithTextCell : FormulaDetailWithTextCell {
    
    var lastItem: FormulaDetailItem? = nil
    
    override func update(with item: FormulaDetailItem) {
      lastItem = item
    }
  }

  // MARK: - FormulaDetailViewControllerDelegateMock -

  final class FormulaDetailViewControllerDelegateMock: FormulaDetailViewControllerDelegate {

    // MARK: - fav

    var favFormulaCallsCount = 0
    var favFormulaCalled: Bool {
      favFormulaCallsCount > 0
    }
    var favFormulaReceivedArguments: (viewController: UIViewController, formula: Formula)?
    var favFormulaReceivedInvocations: [(viewController: UIViewController, formula: Formula)] = []
    var favFormulaClosure: ((UIViewController, Formula) -> Void)?

    func fav(_ viewController: UIViewController, formula: Formula) {
      favFormulaCallsCount += 1
      favFormulaReceivedArguments = (viewController: viewController, formula: formula)
      favFormulaReceivedInvocations.append((viewController: viewController, formula: formula))
      favFormulaClosure?(viewController, formula)
    }
  }
}
