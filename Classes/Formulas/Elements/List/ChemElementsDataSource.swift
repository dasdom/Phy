//  Created by dasdom on 25.08.19.
//
//

import Foundation

protocol ChemElementsDataSourceProtocol: AnyObject {
  var allItems: [ChemElement] { get }
  var filterString: String? { get set }
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func element(for indexPath: IndexPath) -> ChemElement
}

class ChemElementsDataSource : ChemElementsDataSourceProtocol {

  let allItems: [ChemElement]
  private var filteredItems: [ChemElement]
  var filterString: String? {
    didSet {
      if let filterString = filterString, false == filterString.isEmpty {
        filteredItems = allItems.filter({ element in
          if element.abbreviation.contains(filterString) || element.name.localized.contains(filterString) {
            return true
          } else {
            return false
          }
        })
      } else {
        filteredItems = allItems
      }
    }
  }

  init(elements: [ChemElement]) {
    allItems = elements
    filteredItems = allItems
  }

  func numberOfSections() -> Int {
    return 1
  }

  func numberOfRows(in: Int) -> Int {
    return filteredItems.count
  }

  func element(for indexPath: IndexPath) -> ChemElement {
    guard filteredItems.count > indexPath.row else {
      return ChemElement(abbreviation: "", atomMass: 0, chemieBool: true, electronConfiguration: "", group: "", name: "", ordinal: 0, period: 0, yPos: 0, title: "", pauling: "", mostImportantRadioactiveIsotope: 0, decayType: "", lifetime: "", phaseNorm: "", crystalStructure: "")
    }
    return filteredItems[indexPath.row]
  }
}
