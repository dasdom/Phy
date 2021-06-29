//  Created by dasdom on 03.08.19.
//  
//

import Foundation

struct Formula: FormulaCellProtocol, Codable, Equatable {
  let id: UUID
  let imageName: String
  let title: String?
  let accessibilityText: String?
  let details: [FormulaDetail]?
  
  init(id: UUID, imageName: String, title: String?, accessibilityText: String? = nil, details: [FormulaDetail]? = nil) {
    self.id = id
    self.imageName = imageName
    self.title = title
    self.accessibilityText = accessibilityText
    self.details = details
  }
}
