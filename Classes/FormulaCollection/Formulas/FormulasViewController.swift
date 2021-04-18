//  Created by dasdom on 05.08.19.
//  
//

import UIKit

class FormulasViewController: UITableViewController {
  
  let dataSource: FormulasDataSourceProtocol
  
  init(dataSource: FormulasDataSourceProtocol) {
    self.dataSource = dataSource
    
    super.init(style: .plain)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(FormulaCell.self, forCellReuseIdentifier: FormulaCell.identifier)
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: FormulaCell.identifier, for: indexPath) as! FormulaCell
    
    let formula = dataSource.formula(for: indexPath)
    cell.update(with: formula)
    
    if let details = formula.details, details.count > 0 {
      cell.accessoryType = .disclosureIndicator
    }
    
    return cell
  }
  
//  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    let headerView = UIView()
//
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.font = .preferredFont(forTextStyle: .callout)
//    label.numberOfLines = 2
//    label.text = NSLocalizedString(dataSource.titleFor(section: section), comment: "")
//
//    headerView.addSubview(label)
//    headerView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
//
//    NSLayoutConstraint.activate([
//      label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 3),
//      label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
//      label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -3),
//      label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8)
//      ])
//
//    return headerView
//  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return NSLocalizedString(dataSource.titleFor(section: section), comment: "")
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    let formula = dataSource.formula(for: indexPath)

    if let details = formula.details, details.count > 0 {
      let detail = FormulaDetailViewController(formula: formula)
      
      navigationController?.pushViewController(detail, animated: true)
    }
  }
}
