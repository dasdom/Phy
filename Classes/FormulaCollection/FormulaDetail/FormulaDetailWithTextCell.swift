//  Created by dasdom on 10.08.19.
//  
//

import UIKit

class FormulaDetailWithTextCell: DDHBaseTableViewCell<FormulaDetailItem> {

  let detailImageView: UIImageView
  let nameLabel: UILabel
  private var imageHeightConstraint: NSLayoutConstraint?
  private var imageWidthConstraint: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    detailImageView = UIImageView()
    
    nameLabel = UILabel()
    nameLabel.font = .preferredFont(forTextStyle: .body)
    nameLabel.adjustsFontForContentSizeCategory = true
    nameLabel.numberOfLines = 3
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(detailImageView)
    contentView.addSubview(nameLabel)
    
    detailImageView.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    imageHeightConstraint = detailImageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = detailImageView.widthAnchor.constraint(equalToConstant: 20)

    guard let imageHeightConstraint = imageHeightConstraint else { fatalError() }
    guard let imageWidthConstraint = imageWidthConstraint else { fatalError() }
    
    imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)
    
    let nameLabelGreaterThanConstraint = nameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -8)
    nameLabelGreaterThanConstraint.priority = UILayoutPriority(rawValue: 999)

    NSLayoutConstraint .activate([
      detailImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
      detailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      detailImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
      imageWidthConstraint,
      imageHeightConstraint,
      
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: detailImageView.trailingAnchor, constant: 8),
      nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      nameLabelGreaterThanConstraint
      ])
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func update(with item: FormulaDetailItem) {
    
    if let title = item.title {
      nameLabel.text = NSLocalizedString(title, comment: "")
    }
    guard let image = UIImage(named: item.imageName) else {
      print("image missing: \(item.imageName)")
      return
    }
    detailImageView.image = image
    
    imageWidthConstraint?.isActive = false
    
    let size = image.size
    imageWidthConstraint = detailImageView.widthAnchor.constraint(equalTo: detailImageView.heightAnchor, multiplier: size.width/size.height)
    imageWidthConstraint?.isActive = true
    
    traitCollectionDidChange(nil)
    
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    
    detailImageView.update(heightConstraint: imageHeightConstraint)
  }
}
