//  Created by Dominik Hauser on 09/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import SwiftUI
import MessageUI

class FormulasCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
  
  private let presenter: UINavigationController
  private let viewController: TopicViewController

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
      case .formulas:
        let dataSource = SpecialFieldDataSource(json: topic.json)
        let next = SpecialFieldsViewController(style: .insetGrouped, dataSource: dataSource)
        next.title = topic.title.localized
        next.delegate = self
        presenter.pushViewController(next, animated: true)
      case .elements:
        let dataSource = ChemElementsDataSource(json: topic.json)
        let next = ChemElementsTableViewController(style: .plain, dataSource: dataSource)
        next.title = topic.title.localized
        presenter.pushViewController(next, animated: true)
      case .feedback:
        let next = UIHostingController(rootView: FeedbackView(delegate: self))
        presenter.pushViewController(next, animated: true)
    }
  }

  func showImprint(_ viewController: UIViewController) {
    let next = ImprintViewController()
    let nextNavigationController = UINavigationController(rootViewController: next)
    nextNavigationController.modalPresentationStyle = .formSheet
    viewController.present(nextNavigationController, animated: true, completion: nil)
  }
}

extension FormulasCoordinator: SpecialFieldsViewControllerProtocol {
  func specialFieldSelected(_ viewController: UIViewController, specialField: SpecialField) {
    let formulasDataSource = FormulasDataSource(sections: specialField.formulaSections)
    let next = FormulasViewController(dataSource: formulasDataSource)
    next.title = specialField.title.localized
    next.delegate = self
    presenter.pushViewController(next, animated: true)
  }

  func showSearch(_ viewController: UIViewController, specialFieldSections: [SpecialFieldSection]) {
    let searchFormulasDataSource = SearchFormulasDataSource(specialFieldSections: specialFieldSections)
    let next = SearchFormulasViewController(dataSource: searchFormulasDataSource)
    next.delegate = self
    presenter.pushViewController(next, animated: true)
  }
}

extension FormulasCoordinator: FormulasViewControllerProtocol {
  func formulaSelected(_ viewController: UIViewController, formula: Formula) {
    if let details = formula.details, details.count > 0 {
      let detail = FormulaDetailViewController(formula: formula)
      detail.title = formula.title?.localized
      presenter.pushViewController(detail, animated: true)
    }
  }
}

extension FormulasCoordinator: FeedbackViewDelegate {
  func composeMail() {
    if MFMailComposeViewController.canSendMail() {
      let compose = MFMailComposeViewController()
      compose.mailComposeDelegate = self
      presenter.present(compose, animated: true)
    }
  }
}

extension FormulasCoordinator: MFMailComposeViewControllerDelegate {
  
}
