//  Created by dasdom on 05.08.19.
//
//

import Foundation

protocol FormulasDataSourceProtocol {
  func numberOfSections() -> Int
  func numberOfRows(in: Int) -> Int
  func titleFor(section: Int) -> String
  func formula(for: IndexPath) -> Formula
}

class FormulasDataSource: FormulasDataSourceProtocol {
  
  var sections: [FormulaSection]
  
  internal init(sections: [FormulaSection]) {
    self.sections = sections
  }
  
  func numberOfSections() -> Int {
    return sections.count
  }
  
  func numberOfRows(in row: Int) -> Int {
    return sections[row].formulas.count
  }
  
  func titleFor(section: Int) -> String {
    return sections[section].title
  }
  
  func formula(for indexPath: IndexPath) -> Formula {
    return sections[indexPath.section].formulas[indexPath.row]
  }
}
