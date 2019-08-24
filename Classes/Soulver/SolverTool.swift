//  Created by dasdom on 26.07.19.
//  
//

import Foundation

struct SolverTools : Codable {
    let tools: [SolverTool]
}

struct SolverTool : Codable, Equatable {
    var title: String?
    let imageName: String
    var inputs: [SolverInput]
    var results: [SolverResult]
}
