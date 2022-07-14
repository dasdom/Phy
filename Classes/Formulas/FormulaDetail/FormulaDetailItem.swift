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
  let solverImageName: String?
  let type: FormulaDetailItemType?
  let inputs: [SolverInput]?
  let results: [SolverResult]?
  
  init(imageName: String, solverImageName: String? = nil, title: String? = nil, inputs: [SolverInput]? = nil, results: [SolverResult]? = nil, type: FormulaDetailItemType? = nil) {
    self.imageName = imageName
    self.solverImageName = solverImageName
    self.title = title
    self.inputs = inputs
    self.results = results
    self.type = type
  }
}
