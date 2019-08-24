//  Created by dasdom on 08.08.19.
//  
//

import UIKit

class PhyFormulaDetailViewController: UITableViewController {
  
  let formula: PhyFormula
  
  init(formula: PhyFormula) {
    
    self.formula = formula
    
    super.init(style: .grouped)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(PhyFormulaDetailCell.self, forCellReuseIdentifier: PhyFormulaDetailCell.identifier)
    tableView.register(PhyFormulaDetailWithTextCell.self, forCellReuseIdentifier: PhyFormulaDetailWithTextCell.identifier)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return formula.details?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return formula.details?[section].detailItems.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    return formula.details?[section].title
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let detailItem = formula.details?[indexPath.section].detailItems[indexPath.row] else {
      return UITableViewCell()
    }
    
    let cell: DDHBaseTableViewCell<PhyFormulaDetailItem>?
    if detailItem.title?.contains("Abk") ?? false {
      cell = tableView.dequeueReusableCell(withIdentifier: PhyFormulaDetailWithTextCell.identifier, for: indexPath) as? DDHBaseTableViewCell<PhyFormulaDetailItem>
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: PhyFormulaDetailCell.identifier, for: indexPath) as? DDHBaseTableViewCell<PhyFormulaDetailItem>
    }
    
    cell?.update(with: detailItem)
    
    if let inputs = detailItem.inputs, let results = detailItem.results, inputs.count > 0, results.count > 0 {
      cell?.accessoryType = .disclosureIndicator
    }
    
    return cell ?? UITableViewCell()
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let detailItem = formula.details?[indexPath.section].detailItems[indexPath.row] else {
      return
    }
    
    guard let inputs = detailItem.inputs else { return }
    guard let results = detailItem.results else { return }
    
    let solver = SolverTool(title: detailItem.title, imageName: detailItem.imageName, inputs: inputs, results: results)
    let next = SolverDetailViewController(tool: solver)
    
    navigationController?.pushViewController(next, animated: true)
  }
}
