//  Created by dasdom on 05.08.19.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class NameAndFormulaImageCell: DDHBaseTableViewCell<FormulaCellProtocol> {
  
  let nameLabel: UILabel
  let formulaImageView: UIImageView
  private var imageHeightConstraint: NSLayoutConstraint?
  private var imageWidthConstraint: NSLayoutConstraint?
  private var nameTopConstraint: NSLayoutConstraint?
  private var imageTopConstraint: NSLayoutConstraint?
  private var imageBottomConstraint: NSLayoutConstraint?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = .preferredFont(forTextStyle: .body)
    nameLabel.adjustsFontForContentSizeCategory = true
    nameLabel.numberOfLines = 3
    
    formulaImageView = UIImageView()
    formulaImageView.translatesAutoresizingMaskIntoConstraints = false
//    formulaImageView.setContentHuggingPriority(.required, for: .vertical)
//    formulaImageView.setContentHuggingPriority(.required, for: .horizontal)
    
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
  
  override func update(with item: FormulaCellProtocol) {
    if let title = item.title {
      nameLabel.text = NSLocalizedString(title, comment: "")
    }
    
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
    
    let fontMetrics = UIFontMetrics(forTextStyle: .body)
    
    formulaImageView.update(heightConstraint: imageHeightConstraint, fontMetrics: fontMetrics)
    
    nameTopConstraint?.constant = floor(fontMetrics.scaledValue(for: 12))
    imageTopConstraint?.constant = floor(fontMetrics.scaledValue(for: 6))
    imageBottomConstraint?.constant = floor(fontMetrics.scaledValue(for: -12))
    
    tintColor = UIColor.label
  }
}
