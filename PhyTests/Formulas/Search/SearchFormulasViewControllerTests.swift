//  Created by Dominik Hauser on 21/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class SearchFormulasViewControllerTests: XCTestCase {

  var sut: SearchFormulasViewController!

  override func setUpWithError() throws {
    sut = SearchFormulasViewController(specialFieldSections: specialFieldSections)
  }

  override func tearDownWithError() throws {
    sut = nil
  }

  func test_loading_shouldAddSearchBar() {

    let isSubview = sut.searchBar.isDescendant(of: sut.view)

    XCTAssertEqual(isSubview, true)
  }

  func test_loading_shouldSetDelegateOfSearchBarToSut() throws {
    sut.loadViewIfNeeded()

    let delegate = try XCTUnwrap(sut.searchBar.delegate as? UIViewController)

    XCTAssertEqual(delegate, sut)
  }

  func test_searchBarTextDidChange_shouldFindFormulas() throws {
    sut.loadViewIfNeeded()
    let delegate = try XCTUnwrap(sut.searchBar.delegate)

    let searchString = "aa"
    delegate.searchBar?(sut.searchBar, textDidChange: searchString)

    let numberOfRows = sut.collectionView.numberOfItems(inSection: 0)
    XCTAssertEqual(numberOfRows, 2)
  }

  func test_searchBarTextDidChange_shouldFindFormulaSections() throws {
    sut.loadViewIfNeeded()
    let delegate = try XCTUnwrap(sut.searchBar.delegate)

    let searchString = "bb"
    delegate.searchBar?(sut.searchBar, textDidChange: searchString)

    let numberOfRows = sut.collectionView.numberOfItems(inSection: 0)
    XCTAssertEqual(numberOfRows, 3)
  }
}

extension SearchFormulasViewControllerTests {
  var specialFieldSections: [SpecialFieldSection] {
    let formulas = [
      Formula(id: UUID(uuidString: "14A19B00-7C98-4F76-A559-86242D2273B8")!, imageName: "formula_1", title: "aa_formula_1_title"),
      Formula(id: UUID(uuidString: "2A42B130-329F-4533-BE24-5CC129D24A71")!, imageName: "formula_2", title: "formula_2_title"),
      Formula(id: UUID(uuidString: "2A42B130-329F-4533-BE24-5CC129D24A71")!, imageName: "formula_2", title: "aa_formula_2_title")
    ]
    let formulaSections = [FormulaSection(id: UUID(uuidString: "AA58A879-9226-4974-8AAD-1005610AE8A9")!, title: "bb_formulaSection", formulas: formulas)]
    let specialFields = [SpecialField(title: "dummy_specialField", formulaSections: formulaSections)]
    let specialFieldSections = [SpecialFieldSection(title: "dummy_specialFieldSection", specialFields: specialFields)]
    return specialFieldSections
  }
}
