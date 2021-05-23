//  Created by Dominik Hauser on 22/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct ActionRow: View {
  
  let converter: Converter
  
  var body: some View {
    HStack(spacing: 0) {
      Button(action: {
        NotificationCenter.default.post(name: NSNotification.Name("ConverterResultNotification"), object: self, userInfo: ["result": self.converter.output])
      }, label: {
        Text("Zum Rechner")
          .lineLimit(nil)
          .multilineTextAlignment(.center)
      })
      .frame(maxWidth: .infinity,
             maxHeight: .infinity)
      
      Button("Löschen".localized, action: { converter.input = "" })
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
    }
    .buttonStyle(CalcButtonStyle(color: Color("converter_button_color")))
  }
}

struct ActionRow_Previews: PreviewProvider {
  static var previews: some View {
    ActionRow(converter:
                Converter(
                  convertInfo:
                    ConvertInfo(id: 1,
                                fieldName: "Foobar",
                                units: [
                                  Unit(
                                    unit: "Bla",
                                    value: "1.2")
                                ]))
    )
  }
}
