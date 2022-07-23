//  Created by Dominik Hauser on 29/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class FormulaStoreTests: XCTestCase {

  var sut: FormulaStore!

  override func setUpWithError() throws {
    sut = FormulaStore()
  }

  override func tearDownWithError() throws {
    sut = nil
  }

  func test_shouldProvidePhysicsFormulas() {

    let specialFieldSections = sut.specialFieldSections(.physics_formulas)

    XCTAssertGreaterThanOrEqual(specialFieldSections.count, 2)
  }

  func test_shouldProvideElements() {

    let elements = sut.elements()

    XCTAssertGreaterThanOrEqual(elements.count, 2)
  }

  func test_addFavorite_shouldPersistFormula() {
    let uuid = UUID()
    let localSUT = FormulaStore()
    localSUT.addOrRemoveFavorite(formula: Formula(id: uuid, imageName: "Foo", title: "Bar"))

    let secondSUT = FormulaStore()
    let section = secondSUT.favoritesSection(from: [
      FormulaSection(id: UUID(), title: "Bla", formulas: [Formula(id: UUID(), imageName: "aa1", title: "aa2"),
                                              Formula(id: uuid, imageName: "bb1", title: "bb2")])
    ], favoritesUUID: UUID())

    XCTAssertEqual(section?.title, "Favoriten")
    XCTAssertEqual(section?.formulas.first?.referenceUUID, uuid)
    localSUT.addOrRemoveFavorite(formula: Formula(id: uuid, imageName: "Foo", title: "Bar"))
  }

  func test_allFavorites_returnsSectionsWithFavoriteFormulas() throws {

    sut.favorites = []
    let favoriteSectionsBefore = sut.allFavoritesSpecialFieldSections()
    XCTAssertEqual(favoriteSectionsBefore.count, 0)

    let formula = try XCTUnwrap(sut.specialFieldSections(.physics_formulas).first?.specialFields.first?.formulaSections.first?.formulas.first)
    sut.favorites = [formula.id]

    let favoriteSectionsAfter = sut.allFavoritesSpecialFieldSections()
    XCTAssertEqual(favoriteSectionsAfter.count, 1)
  }
}
