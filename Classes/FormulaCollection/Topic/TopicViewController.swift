//  Created by dasdom on 23.08.19.
//  
//

import UIKit

protocol TopicViewControllerProtocol {
  func topicSelected(_ viewController: UIViewController, topic: Topic)
  func showImprint(_ viewController: UIViewController)
}

class TopicViewController: UITableViewController {

  let topicDataSource: TopicDataSourceProtocol
  var delegate: TopicViewControllerProtocol?
  
  init(dataSource: TopicDataSourceProtocol) {
    topicDataSource = dataSource
    
    super.init(style: .insetGrouped)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(TopicCell.self, forCellReuseIdentifier: TopicCell.identifier)
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Impressum", comment: ""), style: .plain, target: self, action: #selector(showImprint(sender:)))
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return topicDataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topicDataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TopicCell.identifier, for: indexPath) as? TopicCell else { return UITableViewCell() }
    
    let topic = topicDataSource.topic(for: indexPath)
    cell.update(with: topic)
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    precondition(delegate != nil)
    
    let topic = topicDataSource.topic(for: indexPath)
    delegate?.topicSelected(self, topic: topic)
  }
  
  @objc func showImprint(sender: UIBarButtonItem) {
    
    precondition(delegate != nil)

    delegate?.showImprint(self)
  }
}
