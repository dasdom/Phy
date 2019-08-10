//  Created by dasdom on 05.08.19.
//  
//

import UIKit

class PhyFormulaCell: DDHBaseTableViewCell<PhyFormula> {
  
  let nameLabel: UILabel
  let formulaImageView: UIImageView
  var imageHeightConstraint: NSLayoutConstraint?
  var imageWidthConstraint: NSLayoutConstraint?
  var nameTopConstraint: NSLayoutConstraint?
  var imageTopConstraint: NSLayoutConstraint?
  var imageBottomConstraint: NSLayoutConstraint?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = .preferredFont(forTextStyle: .body)
    nameLabel.adjustsFontForContentSizeCategory = true
    nameLabel.numberOfLines = 3
    
    formulaImageView = UIImageView()
    formulaImageView.translatesAutoresizingMaskIntoConstraints = false
    
//    let button = UIButton(type: .system)
//    button.titleLabel?.font = .preferredFont(forTextStyle: .body)
//    button.titleLabel?.adjustsFontForContentSizeCategory = true

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(nameLabel)
    contentView.addSubview(formulaImageView)
    
    imageHeightConstraint = formulaImageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = formulaImageView.widthAnchor.constraint(equalToConstant: 20)
    
    nameTopConstraint = nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
    imageTopConstraint = formulaImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6)
    imageBottomConstraint = formulaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
    
    guard let imageHeightConstraint = imageHeightConstraint else { fatalError() }
    guard let imageWidthConstraint = imageWidthConstraint else { fatalError() }
    guard let nameTopConstraint = nameTopConstraint else { fatalError() }
    guard let imageTopConstraint = imageTopConstraint else { fatalError() }
    guard let imageBottomConstraint = imageBottomConstraint else { fatalError() }

    imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)
    imageTopConstraint.priority = UILayoutPriority(rawValue: 999)
    
    NSLayoutConstraint.activate([
      nameTopConstraint,
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      imageTopConstraint,
      formulaImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      imageBottomConstraint,
      formulaImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
      imageHeightConstraint,
      imageWidthConstraint
      ])
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func update(with item: PhyFormula) {
    nameLabel.text = item.title
    
    guard let image = UIImage(named: item.imageName) else {
      print("image missing: \(item.imageName)")
      return
    }
    formulaImageView.image = image
    
    imageWidthConstraint?.isActive = false
    
    let size = image.size
    imageWidthConstraint = formulaImageView.widthAnchor.constraint(equalTo: formulaImageView.heightAnchor, multiplier: size.width/size.height)
    imageWidthConstraint?.isActive = true

    traitCollectionDidChange(nil)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    let fontMetric = UIFontMetrics(forTextStyle: .body)
    
    guard let image = formulaImageView.image else { return }
    let height = floor(fontMetric.scaledValue(for: image.size.height * 2))
    changeImageHeight(to: height)
    
    nameTopConstraint?.constant = floor(fontMetric.scaledValue(for: 12))
    imageTopConstraint?.constant = floor(fontMetric.scaledValue(for: 6))
    imageBottomConstraint?.constant = floor(fontMetric.scaledValue(for: -12))
    
//    print("12: \(floor(fontMetric.scaledValue(for: 12)))")
  }

  func changeImageHeight(to height: CGFloat) {
//    guard let image = formulaImageView.image else { return }
    guard let imageHeightConstraint = imageHeightConstraint else { return }
//    guard let imageWidthConstraint = imageWidthConstraint else { return }
    imageHeightConstraint.constant = height
//    let width = floor(image.size.width * height / image.size.height)
//    imageWidthConstraint.constant = width
  }
}
