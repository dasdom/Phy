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
          
          ValueUnitView(name: "Eingabe".localized, input: $converter.input, selectedIndex: $converter.selectedInputIndex, geometry: geometry, units: units)
          
          ValueUnitView(name: "Ausgabe".localized, input: $converter.output, selectedIndex: $converter.selectedOutputIndex, geometry: geometry, units: units)
          
        }
      }
      
      GeometryReader { geometry in
        VStack {
          
          UtilitiesRow(input: $converter.input)
          
          HStack {
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
            .frame(width: geometry.size.width * 3 / 4 ,
                   height: geometry.size.height * 4 / 5)
            
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
            .frame(width: geometry.size.width / 4 ,
                   height: geometry.size.height * 4 / 5)
          }
        }
        
      }
      .buttonStyle(CalcButtonStyle())
    }
    .navigationBarTitle(Text(converter.convertInfo.fieldName.localized))
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
  
  func applyMinus() {
    if converter.input.contains("e-") {
      converter.input = converter.input.replacingOccurrences(of: "e-", with: "e")
    } else if converter.input.contains("e") {
      converter.input = converter.input.replacingOccurrences(of: "e", with: "e-")
    }
  }
}

struct CalcButton: View {
  
  let value: String
  @Binding var input: String
  
  var body: some View {
    Button(value, action: { input.append(value) })
  }
}

struct ValueUnitView: View {

  let name: String
  @Binding var input: String
  @Binding var selectedIndex: Int
  let geometry: GeometryProxy
  let units: [String]
  
  var body: some View {
    HStack(spacing: 0) {
      Text(name + ":")
        .frame(width: geometry.size.width * 1 / 4)
      Text(input)
        .frame(width: geometry.size.width * 2 / 4)
      Picker("Unit", selection: $selectedIndex, content: {
        ForEach(units.indices, content: { index in
          Text(units[index]).tag(index)
        })
      })
      .frame(width: geometry.size.width / 4,
             height: geometry.size.height / 2 - 20)
      .clipped()
    }
    .padding([.top, .bottom], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    .frame(height: geometry.size.height / 2)
  }
}

struct UtilitiesRow: View {
  
  @Binding var input: String

  var body: some View {
    HStack(spacing: 0) {
      Button("to calc", action: {  })
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
      Button("clear", action: { input = "" })
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
    }
  }
}

struct ConverterView_Previews: PreviewProvider {
  static var previews: some View {
    ConverterView(converter: Converter(convertInfo: ConvertInfo(id: 1, fieldName: "Foo", units: [Unit(unit: "Bar", value: "Baz")])))
  }
}

// https://www.fivestars.blog/articles/button-styles/
struct CalcButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        configuration.label
        Spacer()
      }
      Spacer()
    }
    .border(Color.gray, width: 0.5)
    .background(Color("converter_button_color"))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}
