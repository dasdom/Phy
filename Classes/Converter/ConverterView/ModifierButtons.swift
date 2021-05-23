//  Created by Dominik Hauser on 22/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct ModifierButtons: View {
  
  @ObservedObject var converter: Converter
  let geometry: GeometryProxy
  
  var body: some View {
    VStack {
      Button(action: { converter.input.removeLast() }, label: {
        Image(systemName: "delete.left")
      })
      
      Button(action: applyPlusMinus, label: {
        Image(systemName: "plus.slash.minus")
      })
      
      Button("e", action: applyExponent)
      
      Button("-", action: applyMinus)
    }
    .buttonStyle(CalcButtonStyle(color: Color("converter_button_color")))
    
    .frame(width: geometry.size.width / 4 ,
           height: geometry.size.height * 4 / 5)
  }
  
  func applyPlusMinus() {
    if converter.input.first == "-" {
      converter.input.removeFirst()
    } else {
      converter.input.insert("-", at: String.Index(utf16Offset: 0, in: converter.input))
    }
  }
  
  func applyExponent() {
    if false == converter.input.contains("e") {
      converter.input.append("e")
    }
  }
  
  func applyMinus() {
    if converter.input.contains("e-") {
      converter.input = converter.input.replacingOccurrences(of: "e-", with: "e")
    } else if converter.input.contains("e") {
      converter.input = converter.input.replacingOccurrences(of: "e", with: "e-")
    }
  }
}


struct ModifierButtons_Previews: PreviewProvider {
    static var previews: some View {
      GeometryReader { geometry in
        ModifierButtons(converter:
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
