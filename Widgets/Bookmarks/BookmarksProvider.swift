//  Created by Dominik Hauser on 07.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import WidgetKit

struct BookmarksProvider: TimelineProvider {
  func placeholder(in context: Context) -> BookmarkEntry {
    BookmarkEntry(date: Date(), widgetBookmark: nil)
  }

  func getSnapshot(in context: Context,
                   completion: @escaping (BookmarkEntry) -> ()) {

    let entry = BookmarkEntry(date: Date(), widgetBookmark: nil)
    completion(entry)
  }

  func getTimeline(in context: Context,
                   completion: @escaping (Timeline<BookmarkEntry>) -> ()) {

    let store = BookmarkStore()
    store.loadBookmarks()

    var entries: [BookmarkEntry] = []

    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 10 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!

      let bookmark: WidgetBookmark?
      if store.bookmarks.count > 0 {
        let index = Int.random(in: store.bookmarks.indices)
        bookmark = store.bookmarks[index]
      } else {
        bookmark = nil
      }

      let entry = BookmarkEntry(date: entryDate, widgetBookmark: bookmark)
      entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}
