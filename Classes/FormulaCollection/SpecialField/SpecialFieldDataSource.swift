//  Created by dasdom on 05.08.19.
//  
//

import Foundation

struct SpecialFieldDataSource : SpecialFieldDataSourceProtocol {
  
  private let items: [SpecialFieldSection]
  
  init(json: String) {
    guard let url = Bundle.main.url(forResource: json, withExtension: "json") else { fatalError() }
    
    let data: Data
    do {
      data = try Data(contentsOf: url)
      self.items = try JSONDecoder().decode([SpecialFieldSection].self, from: data)
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
  
  func specialField(for indexPath: IndexPath) -> SpecialField {
    return items[indexPath.section].specialFields[indexPath.row]
  }
}
