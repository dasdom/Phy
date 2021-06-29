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
  
  init(specialFieldSections: [SpecialFieldSection]) {
    self.specialFieldSections = specialFieldSections
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
