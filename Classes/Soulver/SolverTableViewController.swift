//  Created by dasdom on 26.07.19.
//  
//

import UIKit

class SolverTableViewController: UITableViewController {
  
  var solverTools: [SolverTool] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    tableView.register(NameAndFormulaImageCell.self, forCellReuseIdentifier: NameAndFormulaImageCell.identifier)
    
    guard let path = Bundle.main.path(forResource: "solver", ofType: "json") else { fatalError() }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError() }
    
    do {
      solverTools = try JSONDecoder().decode([SolverTool].self, from: data)
    } catch {
      print(error)
    }
  }
  
  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return solverTools.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NameAndFormulaImageCell.identifier, for: indexPath) as? NameAndFormulaImageCell else {
      return UITableViewCell()
    }
    
    let tool = solverTools[indexPath.row]
    cell.update(with: tool)
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let tool = solverTools[indexPath.row]
    
    let detailController = SolverDetailViewController(tool: tool)
    self.show(detailController, sender: self)
  }
}
