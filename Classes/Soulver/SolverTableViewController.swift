//  Created by dasdom on 26.07.19.
//  
//

import UIKit

class SolverTableViewController: UITableViewController {
  
  var solverTools: SolverTools? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(SolverCell.self, forCellReuseIdentifier: SolverCell.identifier)
    
    guard let path = Bundle.main.path(forResource: "solver", ofType: "json") else { fatalError() }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError() }
    
    do {
      solverTools = try JSONDecoder().decode(SolverTools.self, from: data)
    } catch {
      print(error)
    }
  }
  
  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return solverTools?.tools.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SolverCell.identifier, for: indexPath) as? SolverCell else { fatalError() }
    
    if let tool = solverTools?.tools[indexPath.row] {
      cell.update(with: tool)
    }
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let tool = solverTools?.tools[indexPath.row] else { fatalError() }
    
    let detailController = SolverDetailViewController(tool: tool)
    self.show(detailController, sender: self)
  }
}
