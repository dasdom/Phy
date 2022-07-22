//  Created by Dominik Hauser on 17/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
@testable import Phy

// MARK: - ChemElementsDataSourceProtocolMock -

final class ChemElementsDataSourceProtocolMock: ChemElementsDataSourceProtocol {
  var allItems: [ChemElement] = []
  var filterString: String?

  // MARK: - numberOfSections

  var numberOfSectionsCallsCount = 0
  var numberOfSectionsCalled: Bool {
    numberOfSectionsCallsCount > 0
  }
  var numberOfSectionsReturnValue: Int!
  var numberOfSectionsClosure: (() -> Int)?

  func numberOfSections() -> Int {
    numberOfSectionsCallsCount += 1
    return numberOfSectionsClosure.map({ $0() }) ?? numberOfSectionsReturnValue
  }

  // MARK: - numberOfRows

  var numberOfRowsInCallsCount = 0
  var numberOfRowsInCalled: Bool {
    numberOfRowsInCallsCount > 0
  }
  var numberOfRowsInReceivedSection: Int?
  var numberOfRowsInReceivedInvocations: [Int] = []
  var numberOfRowsInReturnValue: Int!
  var numberOfRowsInClosure: ((Int) -> Int)?

  func numberOfRows(in section: Int) -> Int {
    numberOfRowsInCallsCount += 1
    numberOfRowsInReceivedSection = section
    numberOfRowsInReceivedInvocations.append(section)
    return numberOfRowsInClosure.map({ $0(section) }) ?? numberOfRowsInReturnValue
  }

  // MARK: - element

  var elementForCallsCount = 0
  var elementForCalled: Bool {
    elementForCallsCount > 0
  }
  var elementForReceivedIndexPath: IndexPath?
  var elementForReceivedInvocations: [IndexPath] = []
  var elementForReturnValue: ChemElement!
  var elementForClosure: ((IndexPath) -> ChemElement)?

  func element(for indexPath: IndexPath) -> ChemElement {
    elementForCallsCount += 1
    elementForReceivedIndexPath = indexPath
    elementForReceivedInvocations.append(indexPath)
    return elementForClosure.map({ $0(indexPath) }) ?? elementForReturnValue
  }
}
