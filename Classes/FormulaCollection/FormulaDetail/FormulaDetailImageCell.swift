//  Created by Dominik Hauser on 05/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class FormulaDetailImageCell: FormulaDetailCell {

  override func setupConstraints() {
    imageHeightConstraint = detailImageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = detailImageView.widthAnchor.constraint(equalToConstant: 20)
    
    guard let imageHeightConstraint = imageHeightConstraint else { fatalError() }
    guard let imageWidthConstraint = imageWidthConstraint else { fatalError() }
    
    imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)
    
    NSLayoutConstraint .activate([
      detailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      detailImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
      detailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      detailImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
      detailImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageWidthConstraint,
      imageHeightConstraint
    ])
  }
}
