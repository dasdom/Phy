//  Created by dasdom on 03.08.19.
//  
//

import Foundation

struct PhyFormulaDetailItem: Codable, Equatable {
    let title: String?
    let imageName: String
    let inputs: [SolverInput]?
    let results: [SolverResult]?
    
    init(imageName: String, title: String? = nil, inputs: [SolverInput]? = nil, results: [SolverResult]? = nil) {
        self.imageName = imageName
        self.title = title
        self.inputs = inputs
        self.results = results
    }
}
