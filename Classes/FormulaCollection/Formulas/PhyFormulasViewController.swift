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
    
    self.tableView.register(PhyFormulaCell.self, forCellReuseIdentifier: PhyFormulaCell.identifier)
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.dataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: PhyFormulaCell.identifier, for: indexPath) as! PhyFormulaCell
    
    let formula = self.dataSource.formula(for: indexPath)
    cell.update(with: formula)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    return self.dataSource.titleFor(section: section)
  }
}
