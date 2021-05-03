//  Created by dasdom on 03.08.19.
//  
//

import Foundation

struct Formula: FormulaCellProtocol, Codable, Equatable {
  let imageName: String
  let title: String?
  let details: [FormulaDetail]?
  let solverTool: SolverTool?
  
  init(imageName: String, title: String, details: [FormulaDetail]? = nil, solverTool: SolverTool? = nil) {
    self.imageName = imageName
    self.title = title
    self.details = details
    self.solverTool = solverTool
  }
}
