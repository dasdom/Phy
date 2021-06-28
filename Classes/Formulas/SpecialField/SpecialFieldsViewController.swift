//  Created by dasdom on 04.08.19.
//  
//

import UIKit

protocol SpecialFieldsViewControllerProtocol: AnyObject {
  func specialFieldSelected(_ viewController: UIViewController, specialField: SpecialField)
  func showSearch(_ viewController: UIViewController, specialFieldSections: [SpecialFieldSection])
}

class SpecialFieldsViewController: UITableViewController {
  
  let specialFieldDataSource: SpecialFieldDataSourceProtocol
  weak var delegate: SpecialFieldsViewControllerProtocol?
  
  init(style: UITableView.Style, dataSource: SpecialFieldDataSourceProtocol) {
    specialFieldDataSource = dataSource
    
    super.init(style: style)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(SpecialFieldCell.self, forCellReuseIdentifier: SpecialFieldCell.identifier)
    
    let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
    navigationItem.rightBarButtonItem = searchButton
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return specialFieldDataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return specialFieldDataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: SpecialFieldCell.identifier, for: indexPath) as! SpecialFieldCell
    
    let specialField = specialFieldDataSource.specialField(for: indexPath)
    cell.update(with: specialField)
    
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    precondition(delegate != nil)
    
    let specialField = specialFieldDataSource.specialField(for: indexPath)
    delegate?.specialFieldSelected(self, specialField: specialField)
  }
}

// MARK: - Actions
extension SpecialFieldsViewController {
  @objc func search() {
    delegate?.showSearch(self, specialFieldSections: specialFieldDataSource.allSections())
  }
}
