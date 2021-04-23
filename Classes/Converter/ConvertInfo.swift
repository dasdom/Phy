//  Created by Dominik Hauser on 22/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

struct Unit: Decodable {
  let unit: String
  let value: String
}

struct ConvertInfo: Decodable {
  let id: Int
  let fieldName: String
  var units: [Unit]
}
