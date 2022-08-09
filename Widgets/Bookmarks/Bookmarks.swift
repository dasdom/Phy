//  Created by Dominik Hauser on 29.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Bookmarks: Widget {
  let kind: String = "Bookmarks"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: BookmarksProvider()) { entry in
      BookmarksEntryView(entry: entry)
    }
    .configurationDisplayName("Bookmarks")
    .description("Shows a random bookmark.")
    .supportedFamilies([.systemMedium])
  }
}

