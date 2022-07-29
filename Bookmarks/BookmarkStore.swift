//  Created by Dominik Hauser on 29.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import Foundation

class BookmarkStore {
  var bookmarks: [WidgetBookmark] = []

  func loadBookmarks() {
    let url = FileManager.default.bookmarks()

    let favorites: [UUID]
    do {
      let data = try Data(contentsOf: url)
      favorites = try JSONDecoder().decode([UUID].self, from: data)
    } catch {
      print("error \(error) in \(#file)")
      favorites = []
    }

    if favorites.count > 0 {
      let allSpecialFieldSections = specialFieldSections(.physics_formulas) + specialFieldSections(.math_formulas)

      bookmarks = []
      for specialField in allSpecialFieldSections.flatMap({ $0.specialFields }) {

        for formulaSection in specialField.formulaSections {
          let formulas = formulaSection.formulas.filter { formula -> Bool in
            return favorites.contains(formula.id)
          }
          for formula in formulas {
            let bookmark = WidgetBookmark(field: specialField.title, section: formulaSection.title, title: formula.title ?? "", imageName: formula.imageName)
            bookmarks.append(bookmark)
          }
        }
      }
    }
  }

  struct SpecialFieldSection: Decodable {
    let title: String
    let specialFields: [SpecialField]
  }

  struct SpecialField: Decodable {
    let title: String
    let formulaSections: [FormulaSection]
  }

  struct FormulaSection: Decodable {
    let id: UUID
    let title: String
    let formulas: [Formula]
  }

  struct Formula: Decodable {
    let id: UUID
    let imageName: String
    let title: String?
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
