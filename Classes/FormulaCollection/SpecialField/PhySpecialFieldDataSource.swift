//  Created by dasdom on 05.08.19.
//  
//

import Foundation

struct PhySpecialFieldDataSource : PhySpecialFieldDataSourceProtocol {
  
  private let items: [PhySpecialFieldSection]
  
  init(json: String) {
    guard let url = Bundle.main.url(forResource: json, withExtension: "json") else { fatalError() }
    
    let data: Data
    do {
      data = try Data(contentsOf: url)
      self.items = try JSONDecoder().decode([PhySpecialFieldSection].self, from: data)
    } catch {
      print(error)
      self.items = []
    }
  }

  func numberOfSections() -> Int {
    return items.count
  }
  
  func numberOfRows(in section: Int) -> Int {
    return items[section].specialFields.count
  }
  
  func specialField(for indexPath: IndexPath) -> PhySpecialField {
    return items[indexPath.section].specialFields[indexPath.row]
  }
}
