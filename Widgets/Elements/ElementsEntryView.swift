//  Created by Dominik Hauser on 08.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import SwiftUI
import WidgetKit

struct ElementsEntryView: View {
  var entry: ElementsProvider.Entry

  var body: some View {
    ZStack {
      Color(hue: entry.element.atomMass/300, saturation: 0.8, brightness: 0.6)

      VStack {
        HStack {
          Text("\(entry.element.ordinal)")
          Spacer()
          Text(String(format: "%.2lf", entry.element.atomMass))
        }
        .padding([.horizontal])

        Text(entry.element.abbreviation)
          .font(.system(size: 60, weight: .bold, design: .rounded))
        Text("\(entry.element.name)")
          .font(.title2)
      }
      .foregroundColor(.white)
    }
  }
}

struct Elements_Previews: PreviewProvider {
  static var previews: some View {
    ElementsEntryView(entry: ElementEntry(date: Date(), element: ChemElement(abbreviation: "A", atomMass: 50, chemieBool: true, electronConfiguration: "b", group: "c", name: "Name", ordinal: 42, period: 1, yPos: 2, title: "foo", pauling: "e", mostImportantRadioactiveIsotope: 5, decayType: "f", lifetime: "g", phaseNorm: "h", crystalStructure: "i")))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
