//  Created by dasdom on 04.08.19.
//  
//

import Foundation

struct SpecialField : Codable, Equatable {
  internal init(title: String, formulaSections: [FormulaSection]) {
    self.title = title
    self.formulaSections = formulaSections
  }
  
    let title: String
    let formulaSections: [FormulaSection]
}
