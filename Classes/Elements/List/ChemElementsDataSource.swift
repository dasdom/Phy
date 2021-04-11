//  Created by dasdom on 25.08.19.
//  
//

import Foundation

protocol ChemElementsDataSourceProtocol {
  func numberOfSections() -> Int
  func numberOfRows(in: Int) -> Int
  func element(for: IndexPath) -> ChemElement
}

struct ChemElementsDataSource : ChemElementsDataSourceProtocol {
  
  private let items: [ChemElement]
  
  init(json: String) {
    guard let url = Bundle.main.url(forResource: json, withExtension: "json") else { fatalError() }
    
    let data: Data
    do {
      data = try Data(contentsOf: url)
      self.items = try JSONDecoder().decode([ChemElement].self, from: data)
    } catch {
      print(error)
      self.items = []
    }
  }
  
  func numberOfSections() -> Int {
    return 1
  }
  
  func numberOfRows(in: Int) -> Int {
    return items.count
  }
  
  func element(for indexPath: IndexPath) -> ChemElement {
    return items[indexPath.row]
  }
  
  
}
