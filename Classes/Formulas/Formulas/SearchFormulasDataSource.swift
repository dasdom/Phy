//  Created by Dominik Hauser on 30/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

protocol SearchFormulasDataSourceProtocol: FormulasDataSourceProtocol {
  func search(_ string: String, completion: () -> Void)
}

class SearchFormulasDataSource: FormulasDataSource, SearchFormulasDataSourceProtocol {
  
  let allFormulaSections: [FormulaSection]
  
  init(specialFieldSections: [SpecialFieldSection]) {
    
    allFormulaSections = specialFieldSections.flatMap({ $0.specialFields }).flatMap({ $0.formulaSections })
    
    super.init(sections: [])
  }
  
  func search(_ string: String, completion: () -> Void) {
    
    var sections: [FormulaSection] = []
    
    for formulaSection in allFormulaSections {
      let lowercaseTitle = formulaSection.title.localized.lowercased()
      if lowercaseTitle.contains(string.lowercased()) {
        sections.append(formulaSection)
        continue
      }
      let formulas = formulaSection.formulas.filter { formula -> Bool in
        let lowercaseTitle = formula.title?.localized.lowercased()
        return (lowercaseTitle?.contains(string.lowercased()) ?? false)
      }
      if formulas.count > 0 {
        sections.append(FormulaSection(title: formulaSection.title, formulas: formulas))
      }
      
    }
    
    self.sections = sections
    
    completion()
  }
}
