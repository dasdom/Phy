//  Created by Dominik Hauser on 21/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class SearchFormulasViewControllerTests: XCTestCase {

  var sut: SearchFormulasViewController!
  private var mockDataSource: MockDataSource!

  override func setUpWithError() throws {
    mockDataSource = MockDataSource()
    sut = SearchFormulasViewController(dataSource: mockDataSource)
  }

  override func tearDownWithError() throws {
    sut = nil
    mockDataSource = nil
  }

  func test_loading_shouldAddSearchBarToHeader() {
    sut.loadViewIfNeeded()

    let headerView = sut.tableView.tableHeaderView

    XCTAssertTrue(headerView is UISearchBar, "Searchbar")
  }

  func test_loading_shouldSetDelegateOfSearchBarToSut() throws {
    sut.loadViewIfNeeded()

    let searchBar = try XCTUnwrap(sut.tableView.tableHeaderView as? UISearchBar)
    let delegate = try XCTUnwrap(searchBar.delegate as? UIViewController)

    XCTAssertEqual(delegate, sut)
  }

  func test_searchBarTextDidChange_callsDataSource() throws {
    sut.loadViewIfNeeded()
    let searchBar = try XCTUnwrap(sut.tableView.tableHeaderView as? UISearchBar)
    let delegate = try XCTUnwrap(searchBar.delegate)

    let searchString = "Foobar"
    delegate.searchBar?(searchBar, textDidChange: searchString)

    XCTAssertEqual(mockDataSource.lastSearchString, searchString)
  }
}

class MockDataSource : SearchFormulasDataSourceProtocol {

  var lastSearchString: String?

  func numberOfSections() -> Int {
    return 0
  }

  func numberOfRows(in: Int) -> Int {
    return 0
  }

  func titleFor(section: Int) -> String {
    return ""
  }

  func formula(for: IndexPath) -> Formula {
    return Formula(imageName: "foo", title: "bar")
  }

  func search(_ string: String, completion: () -> Void) {
    lastSearchString = string
  }
}
