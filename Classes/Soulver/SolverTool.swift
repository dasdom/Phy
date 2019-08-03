//  Created by dasdom on 26.07.19.
//  
//

import Foundation

struct SolverTools : Codable {
    let tools: [SolverTool]
}

struct SolverTool : Codable {
    let title: String
    let imageName: String
    let input: [SolverInput]
    let results: [SolverResult]
}
