//  Created by dasdom on 24.08.19.
//  
//

import Foundation

@objc class ChemElement: NSObject, Codable {
  @objc let abbreviation: String
  @objc let atomMass: Double
  @objc let chemieBool: Bool
  @objc let electronConfiguration: String
  @objc let group: String
  @objc let name: String
  @objc let ordinal: Int
  @objc let period: Int
  @objc let yPos: Int
  @objc let title: String
  @objc let pauling: String
  let mostImportantRadioactiveIsotope: Int?
  @objc let decayType: String
  @objc let lifetime: String
  @objc let phaseNorm: String
  @objc let crystalStructure: String

  init(abbreviation: String, atomMass: Double, chemieBool: Bool, electronConfiguration: String, group: String, name: String, ordinal: Int, period: Int, yPos: Int, title: String, pauling: String, mostImportantRadioactiveIsotope: Int?, decayType: String, lifetime: String, phaseNorm: String, crystalStructure: String) {
    self.abbreviation = abbreviation
    self.atomMass = atomMass
    self.chemieBool = chemieBool
    self.electronConfiguration = electronConfiguration
    self.group = group
    self.name = name
    self.ordinal = ordinal
    self.period = period
    self.yPos = yPos
    self.title = title
    self.pauling = pauling
    self.mostImportantRadioactiveIsotope = mostImportantRadioactiveIsotope
    self.decayType = decayType
    self.lifetime = lifetime
    self.phaseNorm = phaseNorm
    self.crystalStructure = crystalStructure
  }

  @objc func mostImportantRadioactiveIsotopeString() -> String {
    if let isotope = mostImportantRadioactiveIsotope {
      return "\(isotope)"
    } else {
      return "-"
    }
  }
}
