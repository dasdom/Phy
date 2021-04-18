//  Created by Dominik Hauser on 18/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
@testable import Phy

// MARK: - FormulasDataSourceProtocolMock -

final class FormulasDataSourceProtocolMock: FormulasDataSourceProtocol {
    
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
    var numberOfRowsInReceivedIn: Int?
    var numberOfRowsInReceivedInvocations: [Int] = []
    var numberOfRowsInReturnValue: Int!
    var numberOfRowsInClosure: ((Int) -> Int)?

    func numberOfRows(in section: Int) -> Int {
        numberOfRowsInCallsCount += 1
        numberOfRowsInReceivedIn = section
        numberOfRowsInReceivedInvocations.append(section)
        return numberOfRowsInClosure.map({ $0(section) }) ?? numberOfRowsInReturnValue
    }
    
   // MARK: - titleFor

    var titleForSectionCallsCount = 0
    var titleForSectionCalled: Bool {
        titleForSectionCallsCount > 0
    }
    var titleForSectionReceivedSection: Int?
    var titleForSectionReceivedInvocations: [Int] = []
    var titleForSectionReturnValue: String!
    var titleForSectionClosure: ((Int) -> String)?

    func titleFor(section: Int) -> String {
        titleForSectionCallsCount += 1
        titleForSectionReceivedSection = section
        titleForSectionReceivedInvocations.append(section)
        return titleForSectionClosure.map({ $0(section) }) ?? titleForSectionReturnValue
    }
    
   // MARK: - formula

    var formulaForCallsCount = 0
    var formulaForCalled: Bool {
        formulaForCallsCount > 0
    }
    var formulaForReceivedFor: IndexPath?
    var formulaForReceivedInvocations: [IndexPath] = []
    var formulaForReturnValue: Formula!
    var formulaForClosure: ((IndexPath) -> Formula)?

    func formula(for indexPath: IndexPath) -> Formula {
        formulaForCallsCount += 1
        formulaForReceivedFor = indexPath
        formulaForReceivedInvocations.append(indexPath)
        return formulaForClosure.map({ $0(indexPath) }) ?? formulaForReturnValue
    }
}
