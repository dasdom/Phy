//  Created by Dominik Hauser on 29.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> BookmarkEntry {
    BookmarkEntry(date: Date(), widgetBookmark: nil)
  }

  func getSnapshot(in context: Context,
                   completion: @escaping (BookmarkEntry) -> ()) {

    let entry = BookmarkEntry(date: Date(), widgetBookmark: nil)
    completion(entry)
  }

  func getTimeline(in context: Context,
                   completion: @escaping (Timeline<Entry>) -> ()) {

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

struct BookmarkEntry: TimelineEntry {
  let date: Date
  let widgetBookmark: WidgetBookmark?

  init(date: Date, widgetBookmark: WidgetBookmark?) {
    self.date = date
    self.widgetBookmark = widgetBookmark
  }
}

struct BookmarksEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    VStack {
      if let bookmark = entry.widgetBookmark {
        HStack {
          VStack(alignment: .leading) {
            HStack() {
              Text(bookmark.field.localized)
              Text("-")
              Text(bookmark.section.localized)
            }
            .font(.footnote)

            Text(bookmark.title.localized)
              .font(.headline)
              .bold()
          }
          Spacer()
        }
        if let uiImage = UIImage(named: bookmark.imageName)?.resized(height: 50) {
          Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
      } else {
        Text("No bookmarks found")
      }
    }
    .padding()
  }
}

// https://stackoverflow.com/a/71302612/498796
extension UIImage {
  func resized(to size: CGSize) -> UIImage {
    return UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }

  func resized(width: CGFloat) -> UIImage {
    let size = CGSize(width: width, height: self.size.height * width / self.size.width)
    return UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }

  func resized(height: CGFloat) -> UIImage {
    let size = CGSize(width: self.size.width * height / self.size.height, height: height)
    return UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}

@main
struct Bookmarks: Widget {
  let kind: String = "Bookmarks"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      BookmarksEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
    .supportedFamilies([.systemMedium])
  }
}

struct Bookmarks_Previews: PreviewProvider {
  static var previews: some View {
    BookmarksEntryView(entry: BookmarkEntry(date: Date(), widgetBookmark: WidgetBookmark(field: "Foo", section: "Bar", title: "Baz", imageName: "impulserhaltungssatz")))
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}
