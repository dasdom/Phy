//  Created by dasdom on 23.08.19.
//  
//

import Foundation

struct PhyTopicDataSource : PhyTopicDataSourceProtocol {
  
  private let items: [PhyTopic]
  
  init() {
    guard let url = Bundle.main.url(forResource: "Data", withExtension: "json") else {
      fatalError()
    }
    
    let data: Data
    do {
      data = try Data(contentsOf: url)
      items = try JSONDecoder().decode([PhyTopic].self, from: data)
    } catch {
      print(error)
      items = []
    }
  }
  
  func numberOfSections() -> Int {
    return 1
  }
  
  func numberOfRows(in section: Int) -> Int {
    return items.count
  }
  
  func topic(for indexPath: IndexPath) -> PhyTopic {
    let topic = items[indexPath.row]
    return topic
  }
  
}
