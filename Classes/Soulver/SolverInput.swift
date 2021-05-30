//  Created by dasdom on 26.07.19.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

enum InputType: String, Codable {
  case number
  case angleType
}

struct SolverInput : Codable, Equatable {
  let id: String
  let imageName: String
  let placeholder: String
  let inputType: InputType?
}
