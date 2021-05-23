//  Created by Dominik Hauser on 19/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct ConverterView: View {

  @ObservedObject var converter: Converter
  
  var units: [String] {
    return converter.convertInfo.units.map({ $0.unit })
  }

  var body: some View {
    VStack {
      GeometryReader { geometry in
        VStack(spacing: 0) {
          
          ValueUnitView(name: "Eingabe".localized,
                        input: $converter.input,
                        selectedIndex: $converter.selectedInputIndex,
                        geometry: geometry,
                        units: units)
          
          Divider()
          
          ValueUnitView(name: "Ausgabe".localized,
                        input: $converter.output,
                        selectedIndex: $converter.selectedOutputIndex,
                        geometry: geometry,
                        units: units)
        }
      }
      
      GeometryReader { geometry in
        VStack {
                    
          ActionRow(converter: converter)
          
          HStack {
            NumberButtons(converter: converter, geometry: geometry)
            
            ModifierButtons(converter: converter, geometry: geometry)
          }
        }
        
      }
    }
    .navigationBarTitle(Text(converter.convertInfo.fieldName.localized))
  }
}

struct ConverterView_Previews: PreviewProvider {
  static var previews: some View {
    ConverterView(converter:
                    Converter(convertInfo:
                                ConvertInfo(id: 1,
                                            fieldName: "Foo",
                                            units: [
                                              Unit(unit: "Bar",
                                                   value: "Baz")
                                            ]
                                )
                    )
    )
  }
}
