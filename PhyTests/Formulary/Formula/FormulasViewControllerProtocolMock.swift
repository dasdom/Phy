//  Created by Dominik Hauser on 18/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
@testable import Phy

// MARK: - FormulasViewControllerProtocolMock -

final class FormulasViewControllerProtocolMock: FormulasViewControllerProtocol {
    
   // MARK: - formulaSelected

    var formulaSelectedFormulaCallsCount = 0
    var formulaSelectedFormulaCalled: Bool {
        formulaSelectedFormulaCallsCount > 0
    }
    var formulaSelectedFormulaReceivedArguments: (viewController: UIViewController, formula: Formula)?
    var formulaSelectedFormulaReceivedInvocations: [(viewController: UIViewController, formula: Formula)] = []
    var formulaSelectedFormulaClosure: ((UIViewController, Formula) -> Void)?

    func formulaSelected(_ viewController: UIViewController, formula: Formula) {
        formulaSelectedFormulaCallsCount += 1
        formulaSelectedFormulaReceivedArguments = (viewController: viewController, formula: formula)
        formulaSelectedFormulaReceivedInvocations.append((viewController: viewController, formula: formula))
        formulaSelectedFormulaClosure?(viewController, formula)
    }
}
