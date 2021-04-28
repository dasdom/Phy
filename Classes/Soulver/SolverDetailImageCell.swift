//  Created by dasdom on 12.08.19.
//  
//

import UIKit

class SolverDetailImageCell: DDHBaseTableViewCell<SolverTool> {

  let formulaImageView: UIImageView
  private var imageHeightConstraint: NSLayoutConstraint?
  private var imageWidthConstraint: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    formulaImageView = UIImageView()
    formulaImageView.translatesAutoresizingMaskIntoConstraints = false

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(formulaImageView)
    
    imageHeightConstraint = formulaImageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = formulaImageView.widthAnchor.constraint(equalToConstant: 20)
    
    guard let imageHeightConstraint = imageHeightConstraint else { fatalError() }
    guard let imageWidthConstraint = imageWidthConstraint else { fatalError() }
    
    imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)
        
    NSLayoutConstraint.activate([
      formulaImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      formulaImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
      formulaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      formulaImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
      formulaImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageWidthConstraint,
      imageHeightConstraint
      ])
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func update(with item: SolverTool) {
    
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
    
    formulaImageView.update(heightConstraint: imageHeightConstraint)
    
    tintColor = UIColor.label
  }
}
