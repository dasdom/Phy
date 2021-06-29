//  Created by Dominik Hauser on 29/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct FormulaDetailView: View {

  let formula: Formula

  var body: some View {
    List {
      ForEach(formula.details ?? []) { detail in
        Section(header: Text(detail.title ?? "")) {
          ForEach(detail.detailItems, id: \.imageName) { item in
            DescriptionImageView(item: item)
          }
        }
      }
    }
  }
}

//struct FormulaDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    FormulaDetailView(formula: Form)
//  }
//}
