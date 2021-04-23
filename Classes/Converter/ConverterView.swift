//  Created by Dominik Hauser on 19/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct ConverterView: View {

  @State var output: String = ""
  @ObservedObject var converter: Converter
  
  var units: [String] {
    return converter.convertInfo.units.map({ $0.unit })
  }

  var body: some View {
    VStack {
      GeometryReader { geometry in
        VStack(spacing: 0) {
          
          
          HStack(spacing: 0) {
            Text(converter.input)
              .frame(width: geometry.size.width * 3 / 4,
                     height: geometry.size.height / 2)
            Picker("Unit", selection: $converter.selectedInputIndex, content: {
              ForEach(units, id: \.self, content: { unit in
                Text(unit).tag(unit)
              })
            })
            .frame(width: geometry.size.width / 4,
                   height: geometry.size.height / 2)
            .clipped()
            
          }
          
//          ValueUnit(input: $converter.input, selectedIndex: $converter.selectedInputIndex, geometry: geometry, units: units)
          
          ValueUnit(input: $output, selectedIndex: $converter.selectedOutputIndex, geometry: geometry, units: units)
          
        }
      }
      .padding()
      
      GeometryReader { geometry in
        VStack {
          
          UtilitiesRow(input: $converter.input)
          
          HStack {
            VStack {
              ForEach([[7,8,9],[4,5,6],[1,2,3],[0]], id: \.self) { row in
                HStack {
                  ForEach(row, id: \.self) { num in
                    CalcButton(value: "\(num)", input: $converter.input)
                  }
                }
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
              
              Button(".", action: applyDot)
            }
            .frame(width: geometry.size.width / 4 ,
                   height: geometry.size.height * 4 / 5)
          }
        }
        
      }
      .buttonStyle(CalcButtonStyle())
    }
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
}

struct CalcButton: View {
  
  let value: String
  @Binding var input: String
  
  var body: some View {
    Button(value, action: { input.append(value) })
  }
}

struct ValueUnit: View {
  
  @Binding var input: String
  @Binding var selectedIndex: Int
  let geometry: GeometryProxy
  let units: [String]
  
  var body: some View {
    HStack(spacing: 0) {
      Text(input)
        .frame(width: geometry.size.width * 3 / 4,
               height: geometry.size.height / 2)
      Picker("Favorite Color", selection: $selectedIndex, content: {
        ForEach(units, id: \.self, content: { unit in // <1>
          Text(unit)
        })
      })
      .frame(width: geometry.size.width / 4,
             height: geometry.size.height / 2)
      .clipped()
    }
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
    .background(Color(white: 0.96))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}
