//  Created by Dominik Hauser on 07.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import WidgetKit
import CommonExtensions

struct ElementsProvider: IntentTimelineProvider {

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

  func getSnapshot(for configuration: ViewElementIntent, in context: Context, completion: @escaping (ElementEntry) -> Void) {

    let entry = ElementEntry(date: Date(), element: elements.first!)
    completion(entry)
  }

  func getTimeline(for configuration: ViewElementIntent, in context: Context, completion: @escaping (Timeline<ElementEntry>) -> Void) {

    var entries: [ElementEntry] = []

    let filteredElement = elements.first(where: { $0.name.localized == configuration.element?.displayString })

    let currentDate = Date()
    for hourOffset in 0..<10 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!

      let element: ChemElement
      if let filteredElement = filteredElement {
        element = filteredElement
      } else {
        let index = Int.random(in: elements.indices)
        element = elements[index]
      }

//      let entry = ElementEntry(date: Date(), element: ChemElement(abbreviation: "A", atomMass: 50, chemieBool: true, electronConfiguration: "b", group: "c", name: configuration.element?.displayString ?? "möp", ordinal: 42, period: 1, yPos: 2, title: "foo", pauling: "e", mostImportantRadioactiveIsotope: 5, decayType: "f", lifetime: "g", phaseNorm: "h", crystalStructure: "i"))

      let entry = ElementEntry(date: entryDate, element: element)
      entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)

  }
}
