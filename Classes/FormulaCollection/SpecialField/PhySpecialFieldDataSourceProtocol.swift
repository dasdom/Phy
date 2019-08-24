//  Created by dasdom on 05.08.19.
//  
//

import Foundation

protocol PhySpecialFieldDataSourceProtocol {
  func numberOfSections() -> Int
  func numberOfRows(in: Int) -> Int
  func specialField(for: IndexPath) -> PhySpecialField
}
