//  Created by Dominik Hauser on 09/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import Phy

class FormulasCoordinatorTests: XCTestCase {
  
  private var sut: FormulasCoordinator!
  private var navigationController: MockNavigationController!
  
  override func setUpWithError() throws {
    navigationController = MockNavigationController()
    sut = FormulasCoordinator(presenter: navigationController)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    navigationController = nil
  }
  
  func test_start_pushesViewController() throws {
    
    sut.start()
    
    let viewController = try XCTUnwrap(navigationController.topViewController)
    XCTAssertTrue(viewController is TopicViewController)
  }
  
  func test_start_setsDelegate() throws {
    
    sut.start()
    
    let topicViewController = try XCTUnwrap(navigationController.topViewController as? TopicViewController)
    XCTAssertEqual(topicViewController.delegate as? FormulasCoordinator, sut)
  }
  
  func test_physicsFormulaTopicSelected_pushesSpecialFields() throws {
    let formulaStoreMock = FormulaStoreProtocolMock()
    formulaStoreMock.specialFieldSectionsReturnValue = specialFieldSections()
    sut.formulaStore = formulaStoreMock
    sut.start()
    let topicViewController = try XCTUnwrap(navigationController.topViewController as? TopicViewController)
    let topic = Topic(title: "Foo", type: .physics_formulas)
    
    sut.topicSelected(topicViewController, topic: topic)
    
    let specialField = try XCTUnwrap(navigationController.lastPushedViewController as? SpecialFieldsViewController)
    XCTAssertNotNil(specialField.delegate)
    XCTAssertEqual(formulaStoreMock.specialFieldSectionsCallsCount, 1)
    XCTAssertGreaterThanOrEqual(specialField.specialFieldDataSource.numberOfSections(), 2)
  }

  func test_elementsTopicSelected_pushesChemElements() throws {
    let formulaStoreMock = FormulaStoreProtocolMock()
    formulaStoreMock.elementsReturnValue = elements()
    sut.formulaStore = formulaStoreMock
    sut.start()
    let topicViewController = try XCTUnwrap(navigationController.topViewController as? TopicViewController)
    let topic = Topic(title: "Foo", type: .elements)

    sut.topicSelected(topicViewController, topic: topic)

    let elements = try XCTUnwrap(navigationController.lastPushedViewController as? ChemElementsTableViewController)
//    XCTAssertNotNil(elements.delegate)
    XCTAssertEqual(formulaStoreMock.elementsCallsCount, 1)
    XCTAssertGreaterThanOrEqual(elements.elementsDataSource.numberOfRows(in: 0), 1)
  }
  
  func test_showImprint_showsImprint() throws {
    sut.start()
    let viewControllerStub = ViewControllerStub()
    
    sut.showImprint(viewControllerStub)
    
    let navigationController = try XCTUnwrap(viewControllerStub.lastPresentedViewController as? UINavigationController)
    let topViewController = try XCTUnwrap(navigationController.topViewController)
    XCTAssertTrue(topViewController is ImprintViewController)
  }
  
  func test_specialFieldSelected_pushesFormulas() throws {
    sut.start()
    let viewController = UIViewController()
    let specialField = SpecialField(title: "Foo", formulaSections: [])
    
    sut.specialFieldSelected(viewController, specialField: specialField)
    
    let formulas = try XCTUnwrap(navigationController.lastPushedViewController as? Legacy_FormulasViewController)
    XCTAssertNotNil(formulas.delegate)
  }
  
  func test_formulaSelected_pushesFormulaDetails() throws {
    sut.start()
    let viewController = UIViewController()
    let formula = Formula(id: UUID(), imageName: "foo", title: "Foobar", details: [
      FormulaDetail(title: "Bar", detailItems: [FormulaDetailItem(imageName: "bla")])
    ])
    
    sut.formulaSelected(viewController, formula: formula)
    
    XCTAssertTrue(navigationController.lastPushedViewController is FormulaDetailViewController)
  }

  func test_fav_shouldCallAddMethodInFormulaStore() {
    let formulaStoreMock = FormulaStoreProtocolMock()
    sut.formulaStore = formulaStoreMock

    let formula = Formula(id: UUID(), imageName: "Foo", title: "Bar")
    sut.fav(UIViewController(), formula: formula)

    XCTAssertEqual(formulaStoreMock.addFavoriteFormulaReceivedFormula, formula)
  }
}

// MARK: - Helpers
extension FormulasCoordinatorTests {
  func specialFieldSections() -> [SpecialFieldSection] {
    return [
      SpecialFieldSection(title: "Foo", specialFields: [SpecialField(title: "Bla", formulaSections: []),
                                                        SpecialField(title: "Blub", formulaSections: [])]),
      SpecialFieldSection(title: "Bar", specialFields: [SpecialField(title: "Ta", formulaSections: []),
                                                        SpecialField(title: "Tü", formulaSections: [])]),
    ]
  }

  func elements() -> [ChemElement] {
    return [
      ChemElement(abbreviation: "A", atomMass: 1, chemieBool: true, electronConfiguration: "B", group: "C", name: "D", ordinal: 2, period: 3, yPos: 4, title: "E", pauling: "F", mostImportantRadioactiveIsotope: 5, decayType: "G", lifetime: "H", phaseNorm: "I", crystalStructure: "J")
    ]
  }
}
