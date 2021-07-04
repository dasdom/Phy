//  Created by Dominik Hauser on 09/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import SwiftUI
import MessageUI
import CommonExtensions

class FormulasCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
  
  private let presenter: UINavigationController
  private let viewController: TopicViewController
  lazy var formulaStore: FormulaStoreProtocol = FormulaStore()

  init(presenter: UINavigationController) {
    self.presenter = presenter
    let topicDataSource = TopicDataSource()
    viewController = TopicViewController(dataSource: topicDataSource)
  }
  
  func start() {
    viewController.delegate = self
    presenter.pushViewController(viewController, animated: false)
  }
}

extension FormulasCoordinator: TopicViewControllerProtocol {
  
  func topicSelected(_ viewController: UIViewController, topic: Topic) {
    switch topic.type {
      case .physics_formulas, .math_formulas:
        let specialFieldSections = formulaStore.specialFieldSections(topic.type)
        let dataSource = SpecialFieldDataSource(specialFieldSections: specialFieldSections)
        let next = SpecialFieldsViewController(style: .insetGrouped, dataSource: dataSource)
        next.title = topic.title.localized
        next.delegate = self
        presenter.pushViewController(next, animated: true)
      case .elements:
        let elements = formulaStore.elements()
        let dataSource = ChemElementsDataSource(elements: elements)
        let next = ChemElementsTableViewController(style: .plain, dataSource: dataSource)
        next.title = topic.title.localized
        presenter.pushViewController(next, animated: true)
      case .feedback:
        let next = UIHostingController(rootView: FeedbackView(delegate: self))
        next.title = AppStrings.feedback_title.localized
        presenter.pushViewController(next, animated: true)
    }
  }

  func showImprint(_ viewController: UIViewController) {
    let next = ImprintViewController()
    let nextNavigationController = UINavigationController(rootViewController: next)
    if UIDevice.current.userInterfaceIdiom == .pad {
      nextNavigationController.modalPresentationStyle = .formSheet
    } else {
      nextNavigationController.modalPresentationStyle = .fullScreen
    }
    viewController.present(nextNavigationController, animated: true, completion: nil)
  }
}

extension FormulasCoordinator: SpecialFieldsViewControllerProtocol {
  func specialFieldSelected(_ viewController: UIViewController, specialField: SpecialField) {
//    let formulasDataSource = FormulasDataSource(sections: specialField.formulaSections)
    let next = FormulasViewController(sectionsInSpecialField: specialField.formulaSections, formulaStore: formulaStore)
    next.title = specialField.title.localized
    next.delegate = self
    presenter.pushViewController(next, animated: true)
  }

  func showSearch(_ viewController: UIViewController, specialFieldSections: [SpecialFieldSection]) {
    let next = SearchFormulasViewController(specialFieldSections: specialFieldSections)
    next.delegate = self
    presenter.pushViewController(next, animated: true)
  }
}

extension FormulasCoordinator: FormulasViewControllerProtocol {
  func formulaSelected(_ viewController: UIViewController, formula: Formula) {
    if let details = formula.details, details.count > 0 {
      let detail = FormulaDetailViewController(formula: formula, formulaStore: formulaStore)
      // SwiftUI experiment
//      let detail = UIHostingController(rootView: FormulaDetailView(formula: formula))
      detail.title = formula.title?.localized
      detail.delegate = self
      presenter.pushViewController(detail, animated: true)
    }
  }
}

extension FormulasCoordinator: FeedbackViewDelegate {
  func composeMail() {
    if MFMailComposeViewController.canSendMail() {
      let compose = MFMailComposeViewController()
      compose.mailComposeDelegate = self
      compose.setToRecipients(["dominik.hauser@dasdom.de"])
      compose.setSubject(AppStrings.feedback_mail_subject.localized)
      compose.setMessageBody(AppStrings.feedback_mail_body.localized, isHTML: false)

      presenter.present(compose, animated: true)
    }
  }
}

extension FormulasCoordinator: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}

extension FormulasCoordinator: FormulaDetailViewControllerDelegate {
  func fav(_ viewController: UIViewController, formula: Formula) {
    formulaStore.addOrRemoveFavorite(formula: formula)
  }
}
