//  Created by Dominik Hauser on 30/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

protocol SearchFormulasDataSourceProtocol: FormulasDataSourceProtocol {
  var searchText: String { get set }
}

class SearchFormulasDataSource: FormulasDataSource, SearchFormulasDataSourceProtocol {
  
  let specialField: SpecialField
  var searchText: String = ""
  
  init(specialField: SpecialField) {
    self.specialField = specialField
    
    super.init(sections: [])
  }
}
