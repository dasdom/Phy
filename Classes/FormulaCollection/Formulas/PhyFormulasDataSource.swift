//  Created by dasdom on 05.08.19.
//  
//

import Foundation

struct PhyFormulasDataSource : PhyFormulasDataSourceProtocol {
  
  let sections: [PhyFormulaSection]
  
  func numberOfSections() -> Int {
    return sections.count
  }
  
  func numberOfRows(in row: Int) -> Int {
    return sections[row].formulas.count
  }
  
  func titleFor(section: Int) -> String {
    return sections[section].title
  }
  
  func formula(for indexPath: IndexPath) -> PhyFormula {
    return sections[indexPath.section].formulas[indexPath.row]
  }
  
  
}
