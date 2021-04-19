//  Created by dasdom on 25.08.19.
//  
//

import UIKit

class ChemElementsTableViewController: UITableViewController {

  let elementsDataSource: ChemElementsDataSourceProtocol // = ChemElementsDataSource(json: "data_elements")
  
  init(style: UITableView.Style, dataSource: ChemElementsDataSourceProtocol) {

    elementsDataSource = dataSource

    super.init(style: style)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(ChemElementCell.self, forCellReuseIdentifier: ChemElementCell.identifier)
    
    tableView.tableHeaderView = headerView()
  }
  
  private func headerView() -> UIView {
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
    searchBar.delegate = self
    return searchBar
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return elementsDataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return elementsDataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: ChemElementCell.identifier, for: indexPath) as! ChemElementCell
    
    let element = elementsDataSource.element(for: indexPath)
    cell.update(with: element)
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let element = elementsDataSource.element(for: indexPath)
    let next = ChemElementDetailViewController(element: element)
    navigationController?.pushViewController(next, animated: true)
  }
}

extension ChemElementsTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    elementsDataSource.filterString = searchText
    tableView.reloadData()
  }
}
