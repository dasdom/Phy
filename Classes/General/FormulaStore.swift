//  Created by Dominik Hauser on 29/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

protocol FormulaStoreProtocol {
  func specialFieldSections(_ type: TopicType) -> [SpecialFieldSection]
  func elements() -> [ChemElement]
}

class FormulaStore: FormulaStoreProtocol {

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
}
