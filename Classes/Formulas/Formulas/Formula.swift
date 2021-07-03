//  Created by dasdom on 03.08.19.
//  
//

import Foundation

struct Formula: FormulaCellProtocol, Codable, Equatable, Hashable {
  let id: UUID
  let imageName: String
  let title: String?
  let accessibilityText: String?
  let details: [FormulaDetail]?
  var referenceUUID: UUID? = nil

  init(id: UUID, imageName: String, title: String?, accessibilityText: String? = nil, details: [FormulaDetail]? = nil) {
    self.id = id
    self.imageName = imageName
    self.title = title
    self.accessibilityText = accessibilityText
    self.details = details
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  func copyWithNewUUID() -> Formula {
    var formulaCopy = Formula(id: UUID(), imageName: imageName, title: title, accessibilityText: accessibilityText, details: details)
    formulaCopy.referenceUUID = id
    return formulaCopy
  }
}
