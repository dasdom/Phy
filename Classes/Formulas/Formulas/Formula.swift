//  Created by dasdom on 03.08.19.
//  
//

import Foundation

struct Formula: FormulaCellProtocol, Codable, Equatable {
  let imageName: String
  let title: String?
  let accessibilityText: String?
  let details: [FormulaDetail]?
  
  init(imageName: String, title: String, accessibilityText: String? = nil, details: [FormulaDetail]? = nil) {
    self.imageName = imageName
    self.title = title
    self.accessibilityText = accessibilityText
    self.details = details
  }
}
