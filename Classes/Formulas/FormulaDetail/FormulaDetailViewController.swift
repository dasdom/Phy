//  Created by dasdom on 08.08.19.
//
//

import UIKit

protocol FormulaDetailViewControllerDelegate: AnyObject {
  func fav(_ viewController: UIViewController, formula: Formula)
}

class FormulaDetailViewController: UITableViewController {

  let formula: Formula
  weak var delegate: FormulaDetailViewControllerDelegate?

  init(formula: Formula) {

    self.formula = formula

    super.init(style: .insetGrouped)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(FormulaDetailCell.self, forCellReuseIdentifier: FormulaDetailCell.identifier)
    tableView.register(FormulaDetailWithTextCell.self, forCellReuseIdentifier: FormulaDetailWithTextCell.identifier)
    tableView.register(FormulaDetailImageCell.self, forCellReuseIdentifier: FormulaDetailImageCell.identifier)

    let favButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(fav(_:)))
    navigationItem.rightBarButtonItem = favButton
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return formula.details?.count ?? 0
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return formula.details?[section].detailItems.count ?? 0
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

    guard let title = formula.details?[section].title else {
      return nil
    }
    return NSLocalizedString(title, comment: "")
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let detailItem = formula.details?[indexPath.section].detailItems[indexPath.row] else {
      return UITableViewCell()
    }

    let cell: DDHBaseTableViewCell<FormulaDetailItem>
    let detailItemType = detailItem.type ?? .none
    switch detailItemType {
      case .image:
        cell = tableView.dequeueReusableCell(withIdentifier: FormulaDetailImageCell.identifier, for: indexPath) as! DDHBaseTableViewCell<FormulaDetailItem>
      case .none:
        if detailItem.title?.contains("Abk") ?? false {
          cell = tableView.dequeueReusableCell(withIdentifier: FormulaDetailWithTextCell.identifier, for: indexPath) as! DDHBaseTableViewCell<FormulaDetailItem>
        } else {
          cell = tableView.dequeueReusableCell(withIdentifier: FormulaDetailCell.identifier, for: indexPath) as! DDHBaseTableViewCell<FormulaDetailItem>
        }
    }

    cell.update(with: detailItem)

    if let inputs = detailItem.inputs, let results = detailItem.results, inputs.count > 0, results.count > 0 {
      cell.accessoryType = .disclosureIndicator
      cell.selectionStyle = .default
    } else {
      cell.accessoryView = .none
      cell.selectionStyle = .none
    }

    return cell
  }

  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    guard let detailItem = formula.details?[indexPath.section].detailItems[indexPath.row] else {
      return
    }

    guard let inputs = detailItem.inputs else { return }
    guard let results = detailItem.results else { return }
    guard let title = detailItem.title else { return }

    let solver = SolverTool(title: title, imageName: detailItem.imageName, inputs: inputs, results: results)
    let next = SolverDetailViewController(tool: solver)

    navigationController?.pushViewController(next, animated: true)
  }
}

// MARK: - Actions
extension FormulaDetailViewController {
  @objc func fav(_ sender: UIBarButtonItem) {
    delegate?.fav(self, formula: formula)
  }
}
