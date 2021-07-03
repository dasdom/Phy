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

  // MARK: - addFavorite

  var addFavoriteFormulaCallsCount = 0
  var addFavoriteFormulaCalled: Bool {
    addFavoriteFormulaCallsCount > 0
  }
  var addFavoriteFormulaReceivedFormula: Formula?
  var addFavoriteFormulaReceivedInvocations: [Formula] = []
  var addFavoriteFormulaClosure: ((Formula) -> Void)?

  func addFavorite(formula: Formula) {
    addFavoriteFormulaCallsCount += 1
    addFavoriteFormulaReceivedFormula = formula
    addFavoriteFormulaReceivedInvocations.append(formula)
    addFavoriteFormulaClosure?(formula)
  }

  // MARK: - favoritesSection

  var favoritesSectionFromSectionsCallsCount = 0
  var favoritesSectionFromSectionsCalled: Bool {
    favoritesSectionFromSectionsCallsCount > 0
  }
  var favoritesSectionFromSectionsReceivedFromSections: [FormulaSection]?
  var favoritesSectionFromSectionsReceivedInvocations: [[FormulaSection]] = []
  var favoritesSectionFromSectionsReturnValue: FormulaSection!
  var favoritesSectionFromSectionsClosure: (([FormulaSection]) -> FormulaSection)?

  func favoritesSection(from: [FormulaSection]) -> FormulaSection {
    favoritesSectionFromSectionsCallsCount += 1
    favoritesSectionFromSectionsReceivedFromSections = from
    favoritesSectionFromSectionsReceivedInvocations.append(from)
    return favoritesSectionFromSectionsClosure.map({ $0(from) }) ?? favoritesSectionFromSectionsReturnValue
  }
}


