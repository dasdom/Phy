//  Created by Dominik Hauser on 07.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import WidgetKit

struct ElementsProvider: TimelineProvider {

  let elements: [ChemElement]

  init() {
    guard let url = Bundle.main.url(forResource: "data_elements", withExtension: "json") else { fatalError() }

    do {
      let data = try Data(contentsOf: url)
      elements = try JSONDecoder().decode([ChemElement].self, from: data)
    } catch {
      print("error \(error) in \(#file)")
      elements = []
    }
  }

  func placeholder(in context: Context) -> ElementEntry {
    return ElementEntry(date: Date(), element: elements.first!)
  }

  func getSnapshot(in context: Context, completion: @escaping (ElementEntry) -> Void) {

    let entry = ElementEntry(date: Date(), element: elements.first!)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ElementEntry>) -> Void) {

    var entries: [ElementEntry] = []

    let currentDate = Date()
    for hourOffset in 0..<10 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!

      let index = Int.random(in: elements.indices)
      let element = elements[index]

      let entry = ElementEntry(date: entryDate, element: element)
      entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}
