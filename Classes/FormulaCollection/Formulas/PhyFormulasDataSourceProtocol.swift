//  Created by dasdom on 05.08.19.
//  
//

import Foundation

protocol PhyFormulasDataSourceProtocol {
  func numberOfSections() -> Int
  func numberOfRows(in: Int) -> Int
  func titleFor(section: Int) -> String
  func formula(for: IndexPath) -> PhyFormula
}
