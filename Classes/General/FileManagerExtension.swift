//  Created by Dominik Hauser on 02/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
import CommonExtensions

extension FileManager {
  @objc func historyPath() -> URL {
    return documentsURL().appendingPathComponent("history.json")
  }

  func bookmarks() -> URL {

    let urlInApp = documentsURL().appendingPathComponent("favorites.json")

    if let url = containerURL(forSecurityApplicationGroupIdentifier:
                                "group.com.yourcompany.phy") {

      let bookmarkURL = url.appendingPathComponent("bookmarks.json")
      if false == fileExists(atPath: bookmarkURL.path) {
        if fileExists(atPath: urlInApp.path) {
          try? copyItem(at: urlInApp, to: bookmarkURL)
        }
      }
      return bookmarkURL
    }

    return urlInApp
  }
}
