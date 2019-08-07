//  Created by dasdom on 05.08.19.
//  
//

import UIKit

class PhyFormulaCell: DDHBaseTableViewCell<PhyFormula> {
  
  let nameLabel: UILabel
  let formulaImageView: UIImageView
  var imageHeightConstraint: NSLayoutConstraint?
  var imageWidthConstraint: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = .preferredFont(forTextStyle: .body)
    nameLabel.adjustsFontForContentSizeCategory = true
    nameLabel.numberOfLines = 3
    
    formulaImageView = UIImageView()
    formulaImageView.translatesAutoresizingMaskIntoConstraints = false
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(nameLabel)
    contentView.addSubview(formulaImageView)
    
    imageHeightConstraint = formulaImageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = formulaImageView.widthAnchor.constraint(equalToConstant: 20)

    guard let imageHeightConstraint = imageHeightConstraint else { fatalError() }
    guard let imageWidthConstraint = imageWidthConstraint else { fatalError() }

    imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)

    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      formulaImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
      formulaImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      formulaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      imageHeightConstraint,
      imageWidthConstraint
      ])
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func update(with item: PhyFormula) {
    nameLabel.text = item.title
    
    formulaImageView.image = UIImage(named: item.imageName)

    traitCollectionDidChange(nil)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    let fontMetric = UIFontMetrics(forTextStyle: .body)
    
    guard let image = formulaImageView.image else { return }
    let height = floor(fontMetric.scaledValue(for: image.size.height * 2.5))
    changeImageHeight(to: height)
  }

  func changeImageHeight(to height: CGFloat) {
    guard let image = formulaImageView.image else { return }
    guard let imageHeightConstraint = imageHeightConstraint else { return }
    guard let imageWidthConstraint = imageWidthConstraint else { return }
    imageHeightConstraint.constant = height
    let width = floor(image.size.width * height / image.size.height)
    imageWidthConstraint.constant = width
  }
}
