//  Created by dasdom on 12.08.19.
//  
//

import UIKit

class SolverDetailResultCell: DDHBaseTableViewCell<SolverResult> {

  let resultLabel: UILabel
  let resultImageView: UIImageView
  private var imageHeightConstraint: NSLayoutConstraint?
  private var imageWidthConstraint: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    resultImageView = UIImageView()
    
    resultLabel = UILabel()
    resultLabel.font = .preferredFont(forTextStyle: .body)
    resultLabel.adjustsFontForContentSizeCategory = true
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let stackView = UIStackView(arrangedSubviews: [resultImageView, resultLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 10
    stackView.axis = .vertical
    stackView.alignment = .center

    contentView.addSubview(stackView)
    
    
    imageHeightConstraint = resultImageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = resultImageView.widthAnchor.constraint(equalToConstant: 20)
    
    guard let imageHeightConstraint = imageHeightConstraint else { fatalError() }
    guard let imageWidthConstraint = imageWidthConstraint else { fatalError() }
    
    imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)
    
    resultLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      imageWidthConstraint,
      imageHeightConstraint,
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {fatalError()}
  
  override func update(with item: SolverResult) {
    
    guard let image = UIImage(named: item.imageName) else {
      print("image missing: \(item.imageName)")
      return
    }
    resultImageView.image = image
    
    imageWidthConstraint?.isActive = false
    
    let size = image.size
    imageWidthConstraint = resultImageView.widthAnchor.constraint(equalTo: resultImageView.heightAnchor, multiplier: size.width/size.height)
    imageWidthConstraint?.isActive = true
    
    traitCollectionDidChange(nil)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    
    resultImageView.update(heightConstraint: imageHeightConstraint)
    
    tintColor = UIColor.label
  }
}
