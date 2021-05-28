//  Created by Dominik Hauser on 28/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest

class CalculatorUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_calculator_whenConstantIsSelected_shouldAddConstant() {
    
    let app = XCUIApplication()
    app.launch()
    
    app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()

    let expectedValues = [
      "Gravitationsbeschleunigung, 9.80665 m s⁻²",
      "Normdruck, 101325 Pa",
      "Gravitationskonstante, 6.673e-11 m³ kg⁻¹ s⁻²",
      "absoluter Nullpunkt, -273.15 C",
      "Molvolumen eines idealen Gases, 22.413996 dm³ mol⁻¹",
      "allgemeine Gaskonstante, 8.314472 J K⁻¹ mol⁻¹",
      "Avogadrosche Konstante, 6.02214199e23 mol⁻¹",
      "Boltzmannkonstante, 1.3806503e-23 J K⁻¹",
      "elektrische Feldkonstante, 8.85418782e-12 A s V⁻¹ m⁻¹",
      "magnetische Feldkonstante, 𝜋×4e-7 V s A⁻¹ m⁻¹",
      "Vakuumlichtgeschwindigkeit, 2.99792458e8 m s⁻¹",
      "Boltzmannkonstante, 5.670400e-8 W m⁻² K⁻⁴",
      "Plancksches Wirkungsquantum, 6.62606876e-34 J s",
      "Elementarladung, 1.602176462e-19 C",
      "Ruhemasse des Elektrons, 9.10938199e-31 kg",
      "Ruhemasse des Protons, 1.67262158e-27 kg",
      "Ruhemasse des Neutrons, 1.67492716e-27 kg",
      "Comptonwellenlänge, 2.426310215e-12 m",
      "reduziertes Plancksches Wirkungsquantum, 1.054571596e-34 Js",
      "Sommerfeldsche Feinstrukturkonstante, 7.297352533e-3 ",
      "Rydberg-Konstante, 1.0973731568549e7 m⁻¹"
    ]
    
    expectedValues.forEach { string in
      
      app.buttons["const"].tap()
      
      sleep(1)
      let cell = app.cells[string]
      cell.tap()
      
      app.buttons["="].tap()
    }
  }
}
