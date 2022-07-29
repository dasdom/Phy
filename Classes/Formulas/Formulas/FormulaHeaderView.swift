//  Created by Dominik Hauser on 02/07/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class FormulaHeaderView: UICollectionReusableView {
  let label: UILabel

  override init(frame: CGRect) {

    label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0

    super.init(frame: frame)

    backgroundColor = .systemGroupedBackground

    addSubview(label)

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }

  required init?(coder: NSCoder) { fatalError() }
}
