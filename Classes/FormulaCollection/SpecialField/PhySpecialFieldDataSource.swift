//  Created by dasdom on 05.08.19.
//  
//

import Foundation

struct PhySpecialFieldDataSource : PhySpecialFieldDataSourceProtocol {
  
  private let items: [PhySpecialField]
  
  init() {
    guard let url = Bundle.main.url(forResource: "Data", withExtension: "json") else { fatalError() }
    
    let data: Data
    do {
      data = try Data(contentsOf: url)
      self.items = try JSONDecoder().decode([PhySpecialField].self, from: data)
    } catch {
      print(error)
      self.items = []
    }
  }
  
  var numberOfRows: Int {
    return items.count
  }
  
  func specialField(for indexPath: IndexPath) -> PhySpecialField {
    return items[indexPath.row]
  }
}
