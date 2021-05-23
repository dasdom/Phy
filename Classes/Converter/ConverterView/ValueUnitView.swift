//  Created by Dominik Hauser on 22/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

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

struct ValueUnitView_Previews: PreviewProvider {
  
  @State static var input: String = "1"
  @State static var selectedIndex: Int = 0
  
  static var previews: some View {
    GeometryReader { geometry in
      ValueUnitView(name: "Foo", input: $input, selectedIndex: $selectedIndex, geometry: geometry, units: ["bla", "blub"])
    }
  }
}
