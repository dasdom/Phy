//  Created by Dominik Hauser on 02/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
import CommonExtensions

extension FileManager {
  @objc func historyPath() -> URL {
    return documentsURL().appendingPathComponent("history.json")
  }

  func favorites() -> URL {
    return documentsURL().appendingPathComponent("favorites.json")
  }
}
