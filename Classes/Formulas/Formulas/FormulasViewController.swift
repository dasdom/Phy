//  Created by dasdom on 05.08.19.
//
//

import UIKit

protocol FormulasViewControllerProtocol: AnyObject {
  func formulaSelected(_ viewController: UIViewController, formula: Formula)
}

class FormulasViewController: UITableViewController {
  
  let dataSource: FormulasDataSourceProtocol
  weak var delegate: FormulasViewControllerProtocol?
  
  init(dataSource: FormulasDataSourceProtocol) {
    self.dataSource = dataSource
    
    super.init(style: .plain)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(FormulaListCell.self, forCellReuseIdentifier: FormulaListCell.identifier)
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: FormulaListCell.identifier, for: indexPath) as! FormulaListCell
    
    let formula = dataSource.formula(for: indexPath)
    cell.update(with: formula)
    
    if let details = formula.details, details.count > 0 {
      cell.accessoryType = .disclosureIndicator
      cell.selectionStyle = .default
    } else {
      cell.accessoryType = .none
      cell.selectionStyle = .none
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return NSLocalizedString(dataSource.titleFor(section: section), comment: "")
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    let formula = dataSource.formula(for: indexPath)
    delegate?.formulaSelected(self, formula: formula)
  }
}
