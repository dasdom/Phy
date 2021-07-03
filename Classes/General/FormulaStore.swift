//  Created by Dominik Hauser on 29/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

protocol FormulaStoreProtocol {
  func specialFieldSections(_ type: TopicType) -> [SpecialFieldSection]
  func elements() -> [ChemElement]
  func addOrRemoveFavorite(formula: Formula)
  func favoritesSection(from: [FormulaSection]) -> FormulaSection
  func formulaIsFavorit(_ formula: Formula) -> Bool
}

class FormulaStore: FormulaStoreProtocol {

  var favorites: [UUID]

  init() {
    let url = FileManager.default.favorites()

    do {
      let data = try Data(contentsOf: url)
      favorites = try JSONDecoder().decode([UUID].self, from: data)
    } catch {
      print("error \(error) in \(#file)")
      favorites = []
    }
  }

  func specialFieldSections(_ type: TopicType) -> [SpecialFieldSection] {

    let specialFieldSections: [SpecialFieldSection]
    switch type {
      case .physics_formulas:
        specialFieldSections = loadSpecialFieldSections(from: "data_physics")
      case .math_formulas:
        specialFieldSections = loadSpecialFieldSections(from: "data_math")
      case .elements, .feedback:
        assert(false, "This call is unexpected. Special field sections are only supported for formulas")
        specialFieldSections = []
    }
    return specialFieldSections
  }

  func elements() -> [ChemElement] {
    guard let url = Bundle.main.url(forResource: "data_elements", withExtension: "json") else { fatalError() }

    let elements: [ChemElement]
    do {
      let data = try Data(contentsOf: url)
      elements = try JSONDecoder().decode([ChemElement].self, from: data)
    } catch {
      print("error \(error) in \(#file)")
      elements = []
    }
    return elements
  }

  func addOrRemoveFavorite(formula: Formula) {
    let id = formula.referenceUUID ?? formula.id
    if favorites.contains(id) {
      favorites.removeAll(where: { $0 == id })
    } else {
      favorites.append(formula.id)
    }
    writeFavorites()
  }

  func favoritesSection(from sections: [FormulaSection]) -> FormulaSection {
    let formulas = sections.flatMap({ $0.formulas }).filter({ favorites.contains($0.id) }).map({ $0.copyWithNewUUID() })
    return FormulaSection(title: "Favorites", formulas: formulas)
  }

  func formulaIsFavorit(_ formula: Formula) -> Bool {
    if let id = formula.referenceUUID {
      return favorites.contains(id)
    }
    return favorites.contains(formula.id)
  }
}

// Mark: - Helpers
extension FormulaStore {
  private func loadSpecialFieldSections(from json: String) -> [SpecialFieldSection] {
    guard let url = Bundle.main.url(forResource: json, withExtension: "json") else { fatalError() }

    let specialFieldSections: [SpecialFieldSection]
    do {
      let data = try Data(contentsOf: url)
      specialFieldSections = try JSONDecoder().decode([SpecialFieldSection].self, from: data)
    } catch {
      print(error)
      specialFieldSections = []
    }

    return specialFieldSections
  }

  private func writeFavorites() {
    do {
      let data = try JSONEncoder().encode(favorites)
      try data.write(to: FileManager.default.favorites())
    } catch {
      print("error \(error) in \(#file)")
    }
  }
}
