//  Created by dasdom on 04.08.19.
//  
//

import Foundation

struct FormulaSection: Codable, Equatable {
  let id: UUID
  let title: String
  let formulas: [Formula]
}
