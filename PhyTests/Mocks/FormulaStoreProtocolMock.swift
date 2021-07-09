//  Created by Dominik Hauser on 29/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
@testable import Phy

// MARK: - FormulaStoreProtocolMock -

final class FormulaStoreProtocolMock: FormulaStoreProtocol {

  // MARK: - specialFieldSections

  var specialFieldSectionsCallsCount = 0
  var specialFieldSectionsCalled: Bool {
    specialFieldSectionsCallsCount > 0
  }
  var specialFieldSectionsReceivedType: TopicType?
  var specialFieldSectionsReceivedInvocations: [TopicType] = []
  var specialFieldSectionsReturnValue: [SpecialFieldSection]!
  var specialFieldSectionsClosure: ((TopicType) -> [SpecialFieldSection])?

  func specialFieldSections(_ type: TopicType) -> [SpecialFieldSection] {
    specialFieldSectionsCallsCount += 1
    specialFieldSectionsReceivedType = type
    specialFieldSectionsReceivedInvocations.append(type)
    return specialFieldSectionsClosure.map({ $0(type) }) ?? specialFieldSectionsReturnValue
  }

  // MARK: - allFavoritesSpecialFieldSections

  var allFavoritesSpecialFieldSectionsCallsCount = 0
  var allFavoritesSpecialFieldSectionsCalled: Bool {
    allFavoritesSpecialFieldSectionsCallsCount > 0
  }
  var allFavoritesSpecialFieldSectionsReturnValue: [FormulaSection]!
  var allFavoritesSpecialFieldSectionsClosure: (() -> [FormulaSection])?

  func allFavoritesSpecialFieldSections() -> [FormulaSection] {
    allFavoritesSpecialFieldSectionsCallsCount += 1
    return allFavoritesSpecialFieldSectionsClosure.map({ $0() }) ?? allFavoritesSpecialFieldSectionsReturnValue
  }

  // MARK: - elements

  var elementsCallsCount = 0
  var elementsCalled: Bool {
    elementsCallsCount > 0
  }
  var elementsReturnValue: [ChemElement]!
  var elementsClosure: (() -> [ChemElement])?

  func elements() -> [ChemElement] {
    elementsCallsCount += 1
    return elementsClosure.map({ $0() }) ?? elementsReturnValue
  }

  // MARK: - addOrRemoveFavorite

  var addOrRemoveFavoriteFormulaCallsCount = 0
  var addOrRemoveFavoriteFormulaCalled: Bool {
    addOrRemoveFavoriteFormulaCallsCount > 0
  }
  var addOrRemoveFavoriteFormulaReceivedFormula: Formula?
  var addOrRemoveFavoriteFormulaReceivedInvocations: [Formula] = []
  var addOrRemoveFavoriteFormulaClosure: ((Formula) -> Void)?

  func addOrRemoveFavorite(formula: Formula) {
    addOrRemoveFavoriteFormulaCallsCount += 1
    addOrRemoveFavoriteFormulaReceivedFormula = formula
    addOrRemoveFavoriteFormulaReceivedInvocations.append(formula)
    addOrRemoveFavoriteFormulaClosure?(formula)
  }

  // MARK: - favoritesSection

  var favoritesSectionFromFavoritesUUIDCallsCount = 0
  var favoritesSectionFromFavoritesUUIDCalled: Bool {
    favoritesSectionFromFavoritesUUIDCallsCount > 0
  }
  var favoritesSectionFromFavoritesUUIDReceivedArguments: (sections: [FormulaSection], favoritesUUID: UUID)?
  var favoritesSectionFromFavoritesUUIDReceivedInvocations: [(sections: [FormulaSection], favoritesUUID: UUID)] = []
  var favoritesSectionFromFavoritesUUIDReturnValue: FormulaSection?
  var favoritesSectionFromFavoritesUUIDClosure: (([FormulaSection], UUID) -> FormulaSection?)?

  func favoritesSection(from sections: [FormulaSection], favoritesUUID: UUID) -> FormulaSection? {
    favoritesSectionFromFavoritesUUIDCallsCount += 1
    favoritesSectionFromFavoritesUUIDReceivedArguments = (sections: sections, favoritesUUID: favoritesUUID)
    favoritesSectionFromFavoritesUUIDReceivedInvocations.append((sections: sections, favoritesUUID: favoritesUUID))
    return favoritesSectionFromFavoritesUUIDClosure.map({ $0(sections, favoritesUUID) }) ?? favoritesSectionFromFavoritesUUIDReturnValue
  }

  // MARK: - formulaIsFavorit

  var formulaIsFavoritCallsCount = 0
  var formulaIsFavoritCalled: Bool {
    formulaIsFavoritCallsCount > 0
  }
  var formulaIsFavoritReceivedFormula: Formula?
  var formulaIsFavoritReceivedInvocations: [Formula] = []
  var formulaIsFavoritReturnValue: Bool!
  var formulaIsFavoritClosure: ((Formula) -> Bool)?

  func formulaIsFavorit(_ formula: Formula) -> Bool {
    formulaIsFavoritCallsCount += 1
    formulaIsFavoritReceivedFormula = formula
    formulaIsFavoritReceivedInvocations.append(formula)
    return formulaIsFavoritClosure.map({ $0(formula) }) ?? formulaIsFavoritReturnValue
  }
}
