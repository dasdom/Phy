//  Created by dasdom on 05.08.19.
//  
//

import XCTest
@testable import Phy

class FormulasViewControllerTests: XCTestCase {
  
  var sut: FormulasViewController!
  var formulaStoreMock: FormulaStoreProtocolMock!

  override func setUp() {
    formulaStoreMock = FormulaStoreProtocolMock()
    sut = FormulasViewController(sectionsInSpecialField: formulaSections, formulaStore: formulaStoreMock)
    formulaStoreMock.favoritesSectionFromFavoritesUUIDReturnValue = favoritesSectionToReturn
    sut.beginAppearanceTransition(true, animated: false)
    sut.endAppearanceTransition()
  }
  
  override func tearDown() {
    sut = nil
    formulaStoreMock = nil
  }

  func test_shouldHaveThreeSections() {

    let numberOfSection = sut.collectionView.dataSource?.numberOfSections?(in: sut.collectionView)

    XCTAssertEqual(numberOfSection, 3)
  }
  
  func test_loading_shouldShowFavoritesSection() throws {

    let indexPath = IndexPath(item: 0, section: 0)
    let cell = try XCTUnwrap(cellForRow(at: indexPath, in: sut.collectionView) as? FormulaCollectionViewListCell)

    cell.updateConfiguration(using: cell.configurationState)
    XCTAssertEqual(cell.nameLabel.text, "fav_1_title")
  }

  func test_loading_shouldShowNormalSection() throws {

    let indexPath = IndexPath(item: 0, section: 1)
    let cell = try XCTUnwrap(cellForRow(at: indexPath, in: sut.collectionView) as? FormulaCollectionViewListCell)

    cell.updateConfiguration(using: cell.configurationState)
    XCTAssertEqual(cell.nameLabel.text, "foo_title")
  }

  func test_didSelectRow_shouldCallDelegate() {

    let delegateMock = FormulasViewControllerProtocolMock()
    sut.delegate = delegateMock

    let indexPath = IndexPath(item: 0, section: 0)
    didSelectItem(at: indexPath, in: sut.collectionView)

    XCTAssertEqual(delegateMock.formulaSelectedFormulaReceivedArguments?.formula, favoriteFormula)
  }
}

extension FormulasViewControllerTests {
  var formulaSections: [FormulaSection] {
    return [
      FormulaSection(id: UUID(uuidString: "B981DDA2-14F0-4AF7-A5A6-E83F7284E6A8")!, title: "Foobar", formulas: [
        Formula(id: UUID(uuidString: "B425A6D7-33F3-42C7-94B4-DD13C4E6D07D")!, imageName: "foo", title: "foo_title"),
        Formula(id: UUID(uuidString: "0539909D-16CF-4350-A33B-36C7B308F64F")!, imageName: "bar", title: "bar_title")
      ]),
      FormulaSection(id: UUID(uuidString: "2A42B130-329F-4533-BE24-5CC129D24A71")!, title: "Bla", formulas: [
        Formula(id: UUID(uuidString: "14A19B00-7C98-4F76-A559-86242D2273B8")!, imageName: "bla", title: "bla_title")
      ])
    ]
  }

  var favoriteFormula: Formula {
    return Formula(id: UUID(uuidString: "AA58A879-9226-4974-8AAD-1005610AE8A9")!, imageName: "fav_1", title: "fav_1_title")
  }

  var favoritesSectionToReturn: FormulaSection {
    return FormulaSection(id: UUID(uuidString: "74E2D503-78DF-4CAA-BFB7-936476A5BA26")!, title: "Fav", formulas: [favoriteFormula])
  }
}
