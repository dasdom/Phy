//  Created by dasdom on 04.08.19.
//  
//

import Foundation

struct FormulaDetail: Codable, Equatable, Identifiable {
  let title: String?
  let detailItems: [FormulaDetailItem]

  var id: UUID {
    return UUID()
  }
}
