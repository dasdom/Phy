//  Created by Dominik Hauser on 07.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import SwiftUI

struct BookmarksEntryView : View {
  var entry: BookmarksProvider.Entry

  private static let deeplinkURL: URL = URL(string: "widget-deeplink://")!

  var body: some View {
    if let bookmark = entry.widgetBookmark {
      VStack {
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
        if let uiImage = UIImage(named: bookmark.imageName)?.resized(height: 40) {
          Image(uiImage: uiImage)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
      }
      .padding()
      .widgetURL(URL(string: "widget://\(bookmark.id)")!)
    } else {
      Text("No bookmarks found")
    }
  }
}
