//  Created by Dominik Hauser on 29.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
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

struct Bookmarks_Previews: PreviewProvider {
  static var previews: some View {
    BookmarksEntryView(entry: BookmarkEntry(date: Date(), widgetBookmark: WidgetBookmark(id: UUID(), field: "Foo", section: "Bar", title: "Baz", imageName: "impulserhaltungssatz")))
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}
