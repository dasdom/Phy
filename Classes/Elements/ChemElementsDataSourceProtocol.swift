//  Created by dasdom on 25.08.19.
//  
//

import Foundation

protocol ChemElementsDataSourceProtocol {
  func numberOfSections() -> Int
  func numberOfRows(in: Int) -> Int
  func element(for: IndexPath) -> ChemElement
}
