//  Created by dasdom on 12.08.19.
//  
//

import UIKit

@objc protocol SolverInputAccessoryViewProtocol {
  @objc func addE()
  @objc func togglePlusMinus()
  @objc func next()
}

class SolverDetailInputCell: DDHBaseTableViewCell<SolverInput> {

  let textField: UITextField
  let abbreviationImageView: UIImageView
  private var imageHeightConstraint: NSLayoutConstraint?
  private var imageWidthConstraint: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    abbreviationImageView = UIImageView()
    
    textField = UITextField()
    textField.font = .preferredFont(forTextStyle: .body)
    textField.adjustsFontForContentSizeCategory = true
    textField.keyboardType = .decimalPad
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let stackView = UIStackView(arrangedSubviews: [abbreviationImageView, textField])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 5
    stackView.alignment = .center
    
    contentView.addSubview(stackView)
    
    imageHeightConstraint = abbreviationImageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = abbreviationImageView.widthAnchor.constraint(equalToConstant: 20)
    
    guard let imageHeightConstraint = imageHeightConstraint else { fatalError() }
    guard let imageWidthConstraint = imageWidthConstraint else { fatalError() }
    
    imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)
    
    textField.setContentCompressionResistancePriority(.required, for: .vertical)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      imageWidthConstraint,
      imageHeightConstraint,
      ])
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    toolbar.items = [
      UIBarButtonItem(title: "e", style: .plain, target: nil, action: .addE),
      UIBarButtonItem(image: UIImage(systemName: "plus.slash.minus"), style: .plain, target: nil, action: .togglePlusMinus),
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      UIBarButtonItem(title: "next", style: .plain, target: nil, action: .next)
    ]
    
    textField.inputAccessoryView = toolbar
  }
  
  required init?(coder aDecoder: NSCoder) {fatalError()}
  
  override func update(with item: SolverInput) {
    
    guard let image = UIImage(named: item.imageName) else {
      print("image missing: \(item.imageName)")
      return
    }
    abbreviationImageView.image = image
    
    imageWidthConstraint?.isActive = false
    
    let size = image.size
    imageWidthConstraint = abbreviationImageView.widthAnchor.constraint(equalTo: abbreviationImageView.heightAnchor, multiplier: size.width/size.height)
    imageWidthConstraint?.isActive = true
    
    traitCollectionDidChange(nil)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    
    abbreviationImageView.update(heightConstraint: imageHeightConstraint)
    
    tintColor = UIColor.label
  }
}

private extension Selector {
  static let addE = #selector(SolverInputAccessoryViewProtocol.addE)
  static let togglePlusMinus = #selector(SolverInputAccessoryViewProtocol.togglePlusMinus)
  static let next = #selector(SolverInputAccessoryViewProtocol.next)
}
