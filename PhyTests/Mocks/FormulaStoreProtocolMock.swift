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

  var favoritesSectionFromCallsCount = 0
  var favoritesSectionFromCalled: Bool {
    favoritesSectionFromCallsCount > 0
  }
  var favoritesSectionFromReceivedFrom: [FormulaSection]?
  var favoritesSectionFromReceivedInvocations: [[FormulaSection]] = []
  var favoritesSectionFromReturnValue: FormulaSection!
  var favoritesSectionFromClosure: (([FormulaSection]) -> FormulaSection)?

  func favoritesSection(from: [FormulaSection]) -> FormulaSection {
    favoritesSectionFromCallsCount += 1
    favoritesSectionFromReceivedFrom = from
    favoritesSectionFromReceivedInvocations.append(from)
    return favoritesSectionFromClosure.map({ $0(from) }) ?? favoritesSectionFromReturnValue
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
