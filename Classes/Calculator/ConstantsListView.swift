//  Created by Dominik Hauser on 25/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import SwiftUI

struct ConstantsListView: View {
  
  let constants = CalculatorConstant.allConstants()
  weak var delegate: InsertStringProtocol?
  
  var body: some View {
    List(constants, id: \.id) { constant in
      Button(action: {
        delegate?.insertString(constant.value)
      }, label: {
        VStack(alignment: .leading, spacing: 4) {
          Text(constant.name)
            .font(.body)
          
          Text("\(constant.value) \(constant.unit)")
            .font(.headline)
        }
      })
    }
  }
}

@objc class ConstantsListViewCreator: NSObject {
  @objc static func host(delegate: InsertStringProtocol) -> UIViewController {
    return UIHostingController(rootView: ConstantsListView(delegate: delegate))
  }
}

struct ConstantsListView_Previews: PreviewProvider {
  static var previews: some View {
    ConstantsListView()
  }
}
