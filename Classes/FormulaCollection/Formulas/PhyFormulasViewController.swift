//  Created by dasdom on 05.08.19.
//  
//

import UIKit

class PhyFormulasViewController: UITableViewController {
  
  let dataSource: PhyFormulasDataSourceProtocol
  
  init(dataSource: PhyFormulasDataSourceProtocol) {
    self.dataSource = dataSource
    
    super.init(style: .plain)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(PhyFormulaCell.self, forCellReuseIdentifier: PhyFormulaCell.identifier)
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: PhyFormulaCell.identifier, for: indexPath) as! PhyFormulaCell
    
    let formula = dataSource.formula(for: indexPath)
    cell.update(with: formula)
    
    if let details = formula.details, details.count > 0 {
      cell.accessoryType = .disclosureIndicator
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

    let headerView = UIView()

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .preferredFont(forTextStyle: .callout)
    label.numberOfLines = 2
    label.text = dataSource.titleFor(section: section)

    headerView.addSubview(label)
    headerView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 3),
      label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
      label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -3),
      label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8)
      ])

    return headerView
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    let formula = dataSource.formula(for: indexPath)

    if let details = formula.details, details.count > 0 {
      let detail = PhyFormulaDetailViewController(formula: formula)
      
      navigationController?.pushViewController(detail, animated: true)
    }
  }
}
