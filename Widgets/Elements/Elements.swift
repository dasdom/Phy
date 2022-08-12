//  Created by Dominik Hauser on 08.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Elements: Widget {
  let kind: String = "Elements"

  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ViewElementIntent.self, provider: ElementsProvider()) { entry in
      ElementsEntryView(entry: entry)
    }
    .configurationDisplayName("Elements")
    .description("Shows a random element.")
    .supportedFamilies([.systemSmall])
  }
}
