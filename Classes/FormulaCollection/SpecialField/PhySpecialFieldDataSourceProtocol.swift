//  Created by dasdom on 05.08.19.
//  
//

import Foundation

protocol PhySpecialFieldDataSourceProtocol {
  var numberOfRows: Int { get }
  func specialField(for: IndexPath) -> PhySpecialField
}
