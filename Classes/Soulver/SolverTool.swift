//  Created by dasdom on 26.07.19.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

struct SolverTool: FormulaCellProtocol, Codable, Equatable {
  var title: String?
  let imageName: String
  var inputs: [SolverInput]
  var results: [SolverResult]
}
