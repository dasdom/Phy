//  Created by dasdom on 03.08.19.
//  
//

import Foundation

struct PhyFormula : Codable, Equatable {
    let imageName: String
    let title: String
    let details: [PhyFormulaDetail]?
    
    init(imageName: String, title: String, details: [PhyFormulaDetail]? = nil) {
        self.imageName = imageName
        self.title = title
        self.details = details
    }
}
