//  Created by Dominik Hauser on 08/07/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class FavoritesViewControllerTests: XCTestCase {

  var sut: FavoritesViewController!
  var formulaStoreMock: FormulaStoreProtocolMock!

  override func setUpWithError() throws {
    formulaStoreMock = FormulaStoreProtocolMock()
    sut = FavoritesViewController(formulaStore: formulaStoreMock)
  }

  override func tearDownWithError() throws {
    sut = nil
    formulaStoreMock = nil
  }

  func test_viewAppearance_loadsFavorites() {
    formulaStoreMock.allFavoritesSpecialFieldSectionsReturnValue = [FormulaSection(id: UUID(), title: "Foo", formulas: [Formula(id: UUID(), imageName: "Bar", title: "Baz")])]
    sut.beginAppearanceTransition(true, animated: false)
    sut.endAppearanceTransition()

    let numberOfSection = sut.collectionView.numberOfSections

    XCTAssertEqual(numberOfSection, 1)
  }
}
