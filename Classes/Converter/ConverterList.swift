//  Created by Dominik Hauser on 22/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct ConverterList: View {
  
  @State var converter: Converter? = nil
  let allConverterInfos: [ConvertInfo] = {
    guard let url = Bundle.main.url(forResource: "converter", withExtension: "json") else {
      return []
    }
    do {
      let data = try Data(contentsOf: url)
      let converterInfos = try JSONDecoder().decode([ConvertInfo].self, from: data)
      return converterInfos
    } catch {
      NSLog("error: \(error)")
      return []
    }
  }()
  
  var body: some View {
    NavigationView {
      List(allConverterInfos, id: \.id) { convertInfo -> NavigationLink<Text, ConverterView> in
        let converter = Converter(convertInfo: convertInfo)
        self.converter = converter
        return NavigationLink(destination: ConverterView(converter: converter)) {
          Text(convertInfo.fieldName)
        }
      }
      .listStyle(GroupedListStyle())
      .navigationBarTitle(Text("Konverter"))
    }
  }
}

struct ConverterList_Previews: PreviewProvider {
  static var previews: some View {
    ConverterList()
  }
}
