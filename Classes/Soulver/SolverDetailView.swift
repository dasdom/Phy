//  Created by dasdom on 26.07.19.
//  
//

import UIKit

class SolverDetailView: UIView, UITextFieldDelegate {

  private let tool: SolverTool
  private let imageView: UIImageView
  private let calcButton: UIButton
  private var textFields: [UITextField] = []
  private var labels: [UILabel] = []
  private var resultImageViews: [UIImageView] = []
  
  var inputs: [String] {
    return textFields.map({ textField in
      return textField.text ?? "0"
    })
  }
  
  init(tool: SolverTool) {
    
    self.tool = tool
    
    let image = UIImage(named: tool.imageName)
    self.imageView = UIImageView(image: image)
    
    self.calcButton = UIButton(type: .system)
    self.calcButton.setTitle("Calculate", for: .normal)
    self.calcButton.addTarget(nil, action: .calculate, for: .touchUpInside)
    self.calcButton.isEnabled = false
    
    // ************************************
    super.init(frame: UIScreen.main.bounds)
    // ************************************

    self.backgroundColor = .white
    
    let imageStackView = UIStackView(arrangedSubviews: [imageView])
    imageStackView.alignment = .center
    imageStackView.axis = .vertical
    
    let inputStackView = UIStackView()
    inputStackView.axis = .vertical
    inputStackView.spacing = 5
    
    for input in tool.inputs {
      
      let rowImage = UIImage(named: input.imageName)
      let rowImageView = UIImageView(image: rowImage)
      rowImageView.setContentHuggingPriority(.required, for: .horizontal)
      
      let textField = UITextField()
      textField.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
      textField.delegate = self
      textField.keyboardType = .decimalPad
      textFields.append(textField)
      
      let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
      
      toolBar.items = [
        UIBarButtonItem(title: "e", style: .plain, target: self, action: #selector(insertE(sender:))),
        UIBarButtonItem(title: DDHMinus, style: .plain, target: self, action: #selector(insertMinus(sender:))),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      ]
      
      textField.inputAccessoryView = toolBar
      
      let stackView = UIStackView(arrangedSubviews: [rowImageView, textField])
      stackView.alignment = .center
      stackView.spacing = 5
      inputStackView.addArrangedSubview(stackView)
    }
    
    let resultStackView = UIStackView()
    resultStackView.axis = .vertical
    resultStackView.spacing = 10
    
    for result in tool.results {
      
      let rowImage = UIImage(named: result.imageName)
      let rowImageView = UIImageView(image: rowImage)
      rowImageView.setContentHuggingPriority(.required, for: .horizontal)
      self.resultImageViews.append(rowImageView)
      
      let label = UILabel()
      label.font = UIFont.preferredFont(forTextStyle: .body)
      self.labels.append(label)
      
      let stackView = UIStackView(arrangedSubviews: [rowImageView, label])
      stackView.alignment = .center
      stackView.spacing = 5
      stackView.alignment = .bottom
      
      resultStackView.addArrangedSubview(stackView)
    }
    
    let stackView = UIStackView(arrangedSubviews: [imageStackView, inputStackView, self.calcButton, resultStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 10
    
    self.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
      stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    if let text = textField.text {
      let newString = (text as NSString).replacingCharacters(in: range, with: string)
      
      self.calcButton.isEnabled = textFields.reduce(true) { result, tf -> Bool in
        if tf == textField {
          return result && newString.count > 0
        } else {
          return result && (tf.text?.count ?? 0) > 0
        }
      }
    }
    
    return true
  }
  
//  func textFieldShouldReturn(_ activeTextField: UITextField) -> Bool {
//
//    if self.textFields.last == activeTextField {
//      activeTextField.resignFirstResponder()
//    } else {
//      if let index = self.textFields.firstIndex(of: activeTextField), index + 1 < self.textFields.count {
//        self.textFields[index+1].becomeFirstResponder()
//      }
//    }
//    return false
//  }
  
  func update(with results: [String]) {
    for (idx, result) in results.enumerated() {
      self.labels[idx].text = result
      
      if let imageName = self.tool.results[idx].imageNameShort {
        let image = UIImage(named: imageName)
        self.resultImageViews[idx].image = image
      }
    }
    self.textFields.forEach { textField in
      textField.resignFirstResponder()
    }
  }
  
  @objc func insertE(sender: UIBarButtonItem) {
    for textField in self.textFields {
      if textField.isFirstResponder {
        textField.text?.append("e")
      }
    }
  }
  
  @objc func insertMinus(sender: UIBarButtonItem) {
    for textField in self.textFields {
      if textField.isFirstResponder {
        textField.text?.append(DDHMinus)
      }
    }
  }
}

@objc protocol CalculateProtocol {
  @objc func calculate(sender: UIButton)
}

private extension Selector {
  static let calculate = #selector(CalculateProtocol.calculate(sender:))
}
