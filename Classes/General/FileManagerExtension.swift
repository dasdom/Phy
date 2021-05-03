//  Created by Dominik Hauser on 02/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

extension FileManager {
  var documentsURL: URL {
    if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      return url
    } else {
      fatalError("Could not retrieve documents directory")
    }
  }
  
  @objc func historyPath() -> URL {
    return documentsURL.appendingPathComponent("history.json")
  }
}
