//  Created by dasdom on 26.07.19.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import CommonExtensions
import StoreKit

enum AngleType : Int {
  case rad
  case deg
}

class SolverDetailViewController: UITableViewController, UITextFieldDelegate {
  
  let tool: SolverTool
  var results: [String] = []
  var inputValues: [String]
  var angleType: AngleType?
  var buttonEnabled = false
  var currentTextField: UITextField?
  
  init(tool: SolverTool) {
    
    self.tool = tool
    
    let numberInputs = tool.inputs.filter({ $0.inputType != .angleType })
    inputValues = Array(repeating: "", count: numberInputs.count)
    
    super.init(style: .grouped)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    title = tool.title?.localized

    let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
    share.isEnabled = false
    navigationItem.rightBarButtonItem = share
    
    tableView.register(SolverDetailImageCell.self, forCellReuseIdentifier: SolverDetailImageCell.identifier)
    tableView.register(SolverDetailInputCell.self, forCellReuseIdentifier: SolverDetailInputCell.identifier)
    tableView.register(SolverDetailButtonCell.self, forCellReuseIdentifier: SolverDetailButtonCell.identifier)
    tableView.register(SolverDetailResultCell.self, forCellReuseIdentifier: SolverDetailResultCell.identifier)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

//    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//      SKStoreReviewController.requestReview(in: scene)
//    }
  }
  
  // MARK: UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    guard let section = Section(rawValue: section) else {
      return 0
    }
    
    switch section {
      case .formula, .calculateButton: return 1
      case .input: return tool.inputs.count
      case .output: return tool.results.count
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let section = Section(rawValue: indexPath.section) else {
      return UITableViewCell()
    }
    
    let cell: UITableViewCell
    switch section {
      case .formula:
        let imageCell = SolverDetailImageCell(style: .default, reuseIdentifier: nil)
        
        imageCell.update(with: tool)
        
        cell = imageCell
        
      case .input:
        
        let toolInput = tool.inputs[indexPath.row]
        if let inputType = toolInput.inputType, inputType == .angleType {
          let inputCell = SolverDetailRadOrDegreeInputCell(style: .default, reuseIdentifier: nil)
          inputCell.angleTypeSegmentedControl.addTarget(self, action: #selector(angleTypeChanged(_:)), for: .valueChanged)
          cell = inputCell
        } else {
          let inputCell = SolverDetailInputCell(style: .default, reuseIdentifier: nil)

          inputCell.update(with: tool.inputs[indexPath.row])
          inputCell.textField.tag = indexPath.row
          inputCell.textField.delegate = self
          if let value = toolInput.value {
            inputValues[indexPath.row] = value
          }
          inputCell.textField.text = inputValues[indexPath.row]
          inputCell.textField.returnKeyType = .next
          
          if 0 == indexPath.row {
            inputCell.textField.becomeFirstResponder()
          } else if tool.inputs.count - 1 == indexPath.row {
            inputCell.textField.returnKeyType = .done
          }
          
          cell = inputCell
        }
        
      case .calculateButton:
        let buttonCell = SolverDetailButtonCell(style: .default, reuseIdentifier: nil)
        
        buttonCell.button.addTarget(self, action: #selector(calculate), for: .touchUpInside)
        buttonCell.button.isEnabled = buttonEnabled
        
        cell = buttonCell
        
      case .output:
        let resultCell = SolverDetailResultCell(style: .default, reuseIdentifier: nil)
        
        resultCell.update(with: tool.results[indexPath.row])
        
        if indexPath.row < results.count {
          let toolResult = tool.results[indexPath.row]
          let result = results[indexPath.row]
          resultCell.resultLabel.text = toolResult.resultString(inputs: tool.inputs, inputValues: inputValues, result: result)
        }
        
        cell = resultCell
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    guard let section = Section(rawValue: section) else {
      return nil
    }
    
    return section.title
  }
  
  // MARK: - UITextFieldDelegate
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
    currentTextField = textField
    
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    currentTextField = textField
    
    if let text = textField.text {
      let newString = (text as NSString).replacingCharacters(in: range, with: string)
      
      inputValues[textField.tag] = newString
      
      buttonEnabled = inputValues.reduce(true, { result, input -> Bool in
        return result && (input.count > 0)
      })
      tableView.reloadSections([2], with: .none)
    }
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    let numberOfRowsInInputSection = tableView.numberOfRows(inSection: 1)
    var textFieldFound = false
    for i in 0..<numberOfRowsInInputSection {
      guard let cell = tableView.cellForRow(at: IndexPath(row: i, section: 1)) as? SolverDetailInputCell else { return false }
      
      if true == textFieldFound {
        cell.textField.becomeFirstResponder()
        return false
      } else if cell.textField == textField {
        textFieldFound = true
      }
    }
    
    if true == textFieldFound {
      textField.resignFirstResponder()
      calculate()
    }
    
    return false
  }
}

// MARK: - Actions
extension SolverDetailViewController {

  @objc func angleTypeChanged(_ sender: UISegmentedControl) {
    angleType = AngleType(rawValue: sender.selectedSegmentIndex)
    calculate()
  }
  
  @objc func calculate() {
    
    currentTextField?.resignFirstResponder()
    
    let calculatable = inputValues.reduce(true, { result, input -> Bool in
      return result && (input.count > 0)
    })
    if false == calculatable {
      return
    }
    
    results = []
    
    for result in tool.results {
      
      var formulaString = result.formula
      
      let calculator = Legacy_Calculator()
      for (idx, input) in tool.inputs.enumerated() {
        if let inputType = input.inputType, inputType == .angleType {
          calculator.deg = (angleType == .deg)
        } else {
          let userInput = inputValues[idx]
          formulaString = formulaString.replacingOccurrences(of: "#\(input.id)", with: userInput)
        }
      }
      
      print("formulaString: \(formulaString)")
      let result = calculator.calculate(formulaString)
      results.append(Legacy_Calculator.string(fromResult: result))
    }
    
    tableView.reloadSections([3], with: .fade)

    navigationItem.rightBarButtonItem?.isEnabled = true
  }

  @objc func share(_ sender: UIBarButtonItem) {

    var activityItems: [Any] = []
    for (index, toolResult) in tool.results.enumerated() {
      let result = results[index]
      var resultString = toolResult.resultString(inputs: tool.inputs, inputValues: inputValues, result: result)
      if let title = tool.title?.localized {
        resultString = "\(title) =\n\(resultString)"
      }
      activityItems.append(resultString)
    }

    if false == activityItems.isEmpty {
      let activity = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
      self.present(activity, animated: true)
    }
  }
}

extension SolverDetailViewController: SolverInputAccessoryViewProtocol {
  func addE() {
    addStringIfPossible("e")
  }
  
  func togglePlusMinus() {
    if let textField = currentTextField, let text = textField.text {
      if text.first == "-" {
        textField.text = String(text.dropFirst())
      } else {
        textField.text = "-" + text
      }
    }
  }
  
  func next() {
    let numberOfRowsInInputSection = tableView.numberOfRows(inSection: 1)
    var textFieldFound = false
    for i in 0..<numberOfRowsInInputSection {
      guard let cell = tableView.cellForRow(at: IndexPath(row: i, section: 1)) as? SolverDetailInputCell else {
        currentTextField?.resignFirstResponder()
        calculate()
        return
      }
      
      if true == textFieldFound {
        cell.textField.becomeFirstResponder()
        return
      } else if cell.textField == currentTextField {
        textFieldFound = true
      }
    }
    
    if true == textFieldFound {
      currentTextField?.resignFirstResponder()
      calculate()
    }
  }
  
  private func addStringIfPossible(_ string: String) {
    if let textField = currentTextField, let text = textField.text {
      textField.text = text + string
    }
  }
}

extension SolverDetailViewController {
  enum Section : Int, CaseIterable {
    case formula
    case input
    case calculateButton
    case output
    
    var title: String? {
      let title: String?
      switch self {
        case .formula:
          title = "Formel".localized
        case .input:
          title = "Eingabe".localized
        case .calculateButton:
          title = nil
        case .output:
          title = "Ergebnis".localized
      }
      return title
    }
  }
}
