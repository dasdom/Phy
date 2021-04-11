//  Created by dasdom on 23.08.19.
//  
//

import Foundation

enum TopicType: String, Codable {
  case formulas
  case elements
}

struct Topic : Codable, Equatable {
  let title: String
  let json: String
  let type: TopicType
}
