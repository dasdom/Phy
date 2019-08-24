//  Created by dasdom on 23.08.19.
//  
//

import UIKit

class PhyTopicViewController: UITableViewController {

  var topicDataSource: PhyTopicDataSourceProtocol = PhyTopicDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(PhyTopicCell.self, forCellReuseIdentifier: PhyTopicCell.identifier)
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Impressum", comment: ""), style: .plain, target: self, action: #selector(showImpress(sender:)))
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return topicDataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topicDataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PhyTopicCell.identifier, for: indexPath) as? PhyTopicCell else { return UITableViewCell() }
    
    let topic = topicDataSource.topic(for: indexPath)
    cell.update(with: topic)
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let topic = topicDataSource.topic(for: indexPath)
    let specialFieldDataSource = PhySpecialFieldDataSource(json: topic.json)
    let next = PhySpecialFieldsViewController(style: .grouped, dataSource: specialFieldDataSource)
    navigationController?.pushViewController(next, animated: true)
  }
  
  @objc func showImpress(sender: UIBarButtonItem) {
    let next = ImpressViewController()
    let nextNavigationController = UINavigationController(rootViewController: next)
    nextNavigationController.modalPresentationStyle = .formSheet
    present(nextNavigationController, animated: true, completion: nil)
  }
}
