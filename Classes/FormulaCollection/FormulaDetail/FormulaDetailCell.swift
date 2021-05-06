//  Created by dasdom on 10.08.19.
//  
//

import UIKit

class FormulaDetailCell: DDHBaseTableViewCell<FormulaDetailItem> {

  let detailImageView: UIImageView
  var imageHeightConstraint: NSLayoutConstraint?
  var imageWidthConstraint: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    detailImageView = UIImageView(frame: .zero)
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(detailImageView)
    
    detailImageView.translatesAutoresizingMaskIntoConstraints = false
    
    setupConstraints()
  }
  
  func setupConstraints() {
    imageHeightConstraint = detailImageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = detailImageView.widthAnchor.constraint(equalToConstant: 20)
    
    guard let imageHeightConstraint = imageHeightConstraint else { fatalError() }
    guard let imageWidthConstraint = imageWidthConstraint else { fatalError() }
    
    imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)
    
    NSLayoutConstraint .activate([
      detailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      detailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      detailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      detailImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
      imageWidthConstraint,
      imageHeightConstraint
    ])
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func update(with item: FormulaDetailItem) {
    
    guard let image = UIImage(named: item.imageName) else {
      print("image missing: \(item.imageName)")
      return
    }
    detailImageView.image = image
    
    imageWidthConstraint?.isActive = false
    
    let size = image.size
    imageWidthConstraint = detailImageView.widthAnchor.constraint(equalTo: detailImageView.heightAnchor, multiplier: size.width/size.height)
    imageWidthConstraint?.priority = UILayoutPriority(999)
    imageWidthConstraint?.isActive = true
    
    traitCollectionDidChange(nil)
    
    detailImageView.image = image
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    
    detailImageView.update(heightConstraint: imageHeightConstraint)
    
    tintColor = UIColor.label
  }
}
