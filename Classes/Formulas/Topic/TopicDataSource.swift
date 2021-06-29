//  Created by dasdom on 23.08.19.
//  
//

import Foundation

protocol TopicDataSourceProtocol {
  func numberOfSections() -> Int
  func numberOfRows(in: Int) -> Int
  func topic(for: IndexPath) -> Topic
}

enum TopicSection: Int, CaseIterable {
  case content
  case meta
}

struct TopicDataSource : TopicDataSourceProtocol {
  
  private let items: [Topic]
  
  init() {
    guard let url = Bundle.main.url(forResource: "topics", withExtension: "json") else {
      fatalError()
    }
    
    let data: Data
    do {
      data = try Data(contentsOf: url)
      items = try JSONDecoder().decode([Topic].self, from: data)
    } catch {
      print(error)
      items = []
    }
  }
  
  func numberOfSections() -> Int {
    return TopicSection.allCases.count
  }
  
  func numberOfRows(in section: Int) -> Int {
    guard let topicSection = TopicSection(rawValue: section) else {
      return 0
    }
    
    let numberOfRows: Int
    switch topicSection {
      case .content:
        numberOfRows = items.filter({ $0.type != .feedback }).count
      case .meta:
        numberOfRows = items.filter({ $0.type == .feedback }).count
    }
    
    return numberOfRows
  }
  
  func topic(for indexPath: IndexPath) -> Topic {
    
    guard let topicSection = TopicSection(rawValue: indexPath.section) else {
      assert(false)
      return Topic(title: "", type: .feedback)
    }
    
    let topic: Topic
    switch topicSection {
      case .content:
        topic = items[indexPath.row]
      case .meta:
        let numberOfRowsInPreviousSection = numberOfRows(in: indexPath.section - 1)
        topic = items[indexPath.row + numberOfRowsInPreviousSection]
    }
    return topic
  }
  
}
