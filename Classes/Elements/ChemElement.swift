//  Created by dasdom on 24.08.19.
//  
//

import Foundation

struct ChemElement : Codable, Equatable {
  let abbreviation: String
  let atomMass: Double
  let chemieBool: Bool
  let electronConfiguration: String
  let group: String
  let name: String
  let ordinal: Int
  let period: Int
  let yPos: Int
  let title: String
  let pauling: String
  let mostImportantRadioactiveIsotope: Int?
  let decayType: String
  let lifetime: String
  let phaseNorm: String
  let crystalStructure: String
}
