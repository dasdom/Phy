//  Created by Dominik Hauser on 28/06/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class AddUUIDTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() throws {
    guard let url = Bundle.main.url(forResource: "data_physics", withExtension: "json") else { fatalError() }

    let data = try Data(contentsOf: url)
    let specialFieldSections = try JSONDecoder().decode([SpecialFieldSection].self, from: data)

    var newSpecialFieldSections: [SpecialFieldSection] = []
    for specialFieldSection in specialFieldSections {

      var specialFields: [SpecialField] = []
      for specialField in specialFieldSection.specialFields {

        var formulaSections: [FormulaSection] = []
        for formulaSection in specialField.formulaSections {

//          var formulas: [Formula] = []
//          for formula in formulaSection.formulas {
//
//            let formulaWithUUID = Formula(id: UUID(), imageName: formula.imageName, title: formula.title, accessibilityText: formula.accessibilityText, details: formula.details)
////            print("formula: \(formulaWithUUID)")
//
//            formulas.append(formulaWithUUID)
//          }

          let newFormulaSection = FormulaSection(id: UUID(), title: formulaSection.title, formulas: formulaSection.formulas)
          formulaSections.append(newFormulaSection)
        }

        let newSpecialField = SpecialField(title: specialField.title, formulaSections: formulaSections)
        specialFields.append(newSpecialField)
      }

      let newSpecialFieldSection = SpecialFieldSection(title: specialFieldSection.title, specialFields: specialFields)
      newSpecialFieldSections.append(newSpecialFieldSection)
    }

    let newData = try JSONEncoder().encode(newSpecialFieldSections)
    if let string = String(data: newData, encoding: .utf8) {
      print(string)
    }
  }
}
