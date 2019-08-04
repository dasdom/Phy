//  Created by dasdom on 26.07.19.
//  
//

import UIKit

class SolverDetailViewController: UIViewController, CalculateProtocol {

  let tool: SolverTool
  
  var contentView: SolverDetailView {
    return self.view as! SolverDetailView
  }
  
  init(tool: SolverTool) {
    
    self.tool = tool
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func loadView() {
    let view = SolverDetailView(tool: self.tool)
    
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = tool.title
  }
  
  @objc func calculate(sender: UIButton) {
    
    let inputs = contentView.inputs
    
    guard inputs.count == tool.inputs.count else { fatalError() }
    
    var results: [String] = []
    
    for result in tool.results {
      
      var formulaString = result.formula
      
      for (idx, input) in tool.inputs.enumerated() {
        let userInput = inputs[idx]
        formulaString = formulaString.replacingOccurrences(of: "#\(input.id)", with: userInput)
      }
      
      print(formulaString)
      let result = Calculator().calculate(formulaString)
      results.append(Calculator.string(fromResult: result))
    }
    
    contentView.update(with: results)
  }
}
