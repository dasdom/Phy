//  Created by dasdom on 23.08.19.
//  
//

import Foundation

enum TopicType: String, Codable {
  case physics_formulas
  case math_formulas
  case elements
  case feedback
}

struct Topic : Codable, Equatable {
  let title: String
  let type: TopicType
}
