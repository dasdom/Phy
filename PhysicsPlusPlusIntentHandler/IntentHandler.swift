//  Created by Dominik Hauser on 11.08.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

import Intents
import CommonExtensions

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler: ViewElementIntentHandling {
  func provideElementOptionsCollection(for intent: ViewElementIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<Element>?, Error?) -> Void) {

    guard let url = Bundle.main.url(forResource: "data_elements", withExtension: "json") else { fatalError() }

    let chemElements: [ChemElement]
    do {
      let data = try Data(contentsOf: url)
      chemElements = try JSONDecoder().decode([ChemElement].self, from: data)
    } catch {
      print("error \(error) in \(#file)")
      chemElements = []
    }

    let elements: [Element]
    if let lowercaseSearchTerm = searchTerm?.lowercased() {
      elements = chemElements.filter({ $0.name.localized.lowercased().contains(lowercaseSearchTerm) }).map({ chemElement in
        return Element(identifier: "\(chemElement.ordinal)", display: chemElement.name.localized)
      })
    } else {
      elements = [Element(identifier: "-1", display: "Random")] + chemElements.map({ chemElement in
        return Element(identifier: "\(chemElement.ordinal)", display: chemElement.name.localized)
      })
    }
//    let elements = [Element(identifier: "1", display: "Wasserstoff")]

    let collection = INObjectCollection(items: elements)
    completion(collection, nil)
  }

  func defaultElement(for intent: ViewElementIntent) -> Element? {
    return Element(identifier: "-1", display: "Random")
  }
}
