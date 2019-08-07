//  Created by dasdom on 04.08.19.
//  
//

import UIKit

class PhySpecialFieldsViewController: UITableViewController {
  
  lazy var specialFieldDataSource: PhySpecialFieldDataSourceProtocol = PhySpecialFieldDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.register(PhySpecialFieldCell.self, forCellReuseIdentifier: PhySpecialFieldCell.identifier)
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return specialFieldDataSource.numberOfRows
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: PhySpecialFieldCell.identifier, for: indexPath) as! PhySpecialFieldCell
    
    let specialField = specialFieldDataSource.specialField(for: indexPath)
    cell.update(with: specialField)
    
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let specialField = specialFieldDataSource.specialField(for: indexPath)
    let formulasDataSource = PhyFormulasDataSource(sections: specialField.formulaSections)
    let next = PhyFormulasViewController(dataSource: formulasDataSource)
    
    navigationController?.pushViewController(next, animated: true)
  }
}
