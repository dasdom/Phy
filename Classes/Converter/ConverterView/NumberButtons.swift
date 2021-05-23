//  Created by Dominik Hauser on 22/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct NumberButtons: View {
  
  @ObservedObject var converter: Converter
  let geometry: GeometryProxy
  
  var body: some View {
    VStack {
      ForEach([[7,8,9],[4,5,6],[1,2,3]], id: \.self) { row in
        HStack {
          ForEach(row, id: \.self) { num in
            CalcButton(value: "\(num)", input: $converter.input)
          }
        }
      }
      
      HStack {
        Button("0", action: applyZero)
          .frame(width: geometry.size.width * 2 / 4)
        Button(".", action: applyDot)
      }
    }
    .buttonStyle(CalcButtonStyle(color: Color("converter_button_num_color")))
    .frame(width: geometry.size.width * 3 / 4 ,
           height: geometry.size.height * 4 / 5)
  }
  
  func applyDot() {
    if false == converter.input.contains(".") {
      converter.input.append(".")
    }
  }
  
  func applyZero() {
    if "0" != converter.input {
      converter.input.append("0")
    }
  }
}

struct NumberButtons_Previews: PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      NumberButtons(converter:
                      Converter(
                        convertInfo:
                          ConvertInfo(id: 1,
                                      fieldName: "Foobar",
                                      units: [
                                        Unit(
                                          unit: "Bla",
                                          value: "1.2")
                                      ])),
                    geometry: geometry)
    }
  }
}
