//  Created by Dominik Hauser on 29.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import Foundation

struct WidgetBookmark: Codable {
  let id: UUID
  let field: String
  let section: String
  let title: String
  let imageName: String
}
