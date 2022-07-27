//  Created by Dominik Hauser on 29/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import CommonExtensions

class FormulaListCell: NameAndFormulaImageTableViewCell {

  let toolsIndicatorImageView: UIImageView
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    toolsIndicatorImageView = UIImageView(image: UIImage(systemName: "wrench.and.screwdriver"))
    toolsIndicatorImageView.translatesAutoresizingMaskIntoConstraints = false
    toolsIndicatorImageView.isHidden = true
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.insertSubview(toolsIndicatorImageView, belowSubview: self.formulaImageView)
    
    NSLayoutConstraint.activate([
      toolsIndicatorImageView.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor),
      toolsIndicatorImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5),
      
      toolsIndicatorImageView.widthAnchor.constraint(equalToConstant: 16),
      toolsIndicatorImageView.heightAnchor.constraint(equalTo: toolsIndicatorImageView.widthAnchor),
    ])
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func update(with item: FormulaCellProtocol) {
    super.update(with: item)
    
    if let formula = item as? Formula {
      let solvers = formula.details?.flatMap({ $0.detailItems }).filter({ detailItem in
        return false == detailItem.inputs?.isEmpty
      })
      if false == solvers?.isEmpty {
        toolsIndicatorImageView.isHidden = false
      } else {
        toolsIndicatorImageView.isHidden = true
      }
    }
    
    let accessibilityText = item.imageName.localized
    if accessibilityText != item.imageName {
      formulaImageView.isAccessibilityElement = true
      formulaImageView.accessibilityLabel = accessibilityText
    } else {
      formulaImageView.isAccessibilityElement = false
    }
  }
}
