//  Created by Dominik Hauser on 07.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import WidgetKit

struct BookmarkEntry: TimelineEntry {
  let date: Date
  let widgetBookmark: WidgetBookmark?

  init(date: Date, widgetBookmark: WidgetBookmark?) {
    self.date = date
    self.widgetBookmark = widgetBookmark
  }
}
