//  Created by Dominik Hauser on 29/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
@testable import Phy

// MARK: - FormulaStoreProtocolMock -

final class FormulaStoreProtocolMock: FormulaStoreProtocol {

  // MARK: - specialFieldSections

  var specialFieldSectionsCallsCount = 0
  var specialFieldSectionsCalled: Bool {
    specialFieldSectionsCallsCount > 0
  }
  var specialFieldSectionsReceivedType: TopicType?
  var specialFieldSectionsReceivedInvocations: [TopicType] = []
  var specialFieldSectionsReturnValue: [SpecialFieldSection]!
  var specialFieldSectionsClosure: ((TopicType) -> [SpecialFieldSection])?

  func specialFieldSections(_ type: TopicType) -> [SpecialFieldSection] {
    specialFieldSectionsCallsCount += 1
    specialFieldSectionsReceivedType = type
    specialFieldSectionsReceivedInvocations.append(type)
    return specialFieldSectionsClosure.map({ $0(type) }) ?? specialFieldSectionsReturnValue
  }
}
