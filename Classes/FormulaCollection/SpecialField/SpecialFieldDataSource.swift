//  Created by dasdom on 05.08.19.
//  
//

import Foundation

protocol SpecialFieldDataSourceProtocol {
  func numberOfSections() -> Int
  func numberOfRows(in: Int) -> Int
  func specialField(for: IndexPath) -> SpecialField
  func allSections() -> [SpecialFieldSection]
}

struct SpecialFieldDataSource : SpecialFieldDataSourceProtocol {
  
  private let specialFieldSections: [SpecialFieldSection]
  
  init(json: String) {
    guard let url = Bundle.main.url(forResource: json, withExtension: "json") else { fatalError() }
    
    let data: Data
    do {
      data = try Data(contentsOf: url)
      self.specialFieldSections = try JSONDecoder().decode([SpecialFieldSection].self, from: data)
    } catch {
      print(error)
      self.specialFieldSections = []
    }
  }

  func numberOfSections() -> Int {
    return specialFieldSections.count
  }
  
  func numberOfRows(in section: Int) -> Int {
    return specialFieldSections[section].specialFields.count
  }
  
  func specialField(for indexPath: IndexPath) -> SpecialField {
    return specialFieldSections[indexPath.section].specialFields[indexPath.row]
  }
  
  func allSections() -> [SpecialFieldSection] {
    return specialFieldSections
  }
}
