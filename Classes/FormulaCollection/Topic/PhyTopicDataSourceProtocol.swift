//  Created by dasdom on 23.08.19.
//  
//

import Foundation

protocol PhyTopicDataSourceProtocol {
  func numberOfSections() -> Int
  func numberOfRows(in: Int) -> Int
  func topic(for: IndexPath) -> PhyTopic
}
