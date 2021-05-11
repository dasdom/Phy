//  Created by dasdom on 03.08.19.
//  
//

import Foundation

enum FormulaDetailItemType: String, Codable {
  case none
  case image
}

struct FormulaDetailItem: Codable, Equatable {
  let title: String?
  let imageName: String
  let type: FormulaDetailItemType?
  let inputs: [SolverInput]?
  let results: [SolverResult]?
  
  init(imageName: String, title: String? = nil, inputs: [SolverInput]? = nil, results: [SolverResult]? = nil, type: FormulaDetailItemType? = nil) {
    self.imageName = imageName
    self.title = title
    self.inputs = inputs
    self.results = results
    self.type = type
  }
}
