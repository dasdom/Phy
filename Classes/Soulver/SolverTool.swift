//  Created by dasdom on 26.07.19.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

struct SolverTool: FormulaCellProtocol, Codable, Equatable {
  var title: String?
  let imageName: String
  let solverImageName: String?
  var inputs: [SolverInput]
  var results: [SolverResult]

  init(title: String? = nil, imageName: String, solverImageName: String? = nil, inputs: [SolverInput], results: [SolverResult]) {
    self.title = title
    self.imageName = imageName
    self.solverImageName = solverImageName
    self.inputs = inputs
    self.results = results
  }
}
