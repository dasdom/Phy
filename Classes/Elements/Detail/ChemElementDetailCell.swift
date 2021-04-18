//  Created by Dominik Hauser on 11/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class ChemElementDetailCell: UITableViewCell {
  
  private let nameLabel: UILabel
  private let valueLabel: UILabel
  var name: String? {
    return nameLabel.text
  }
  var value: String? {
    return valueLabel.text
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    nameLabel = UILabel()
    nameLabel.font = .preferredFont(forTextStyle: .body)
    nameLabel.numberOfLines = 0
//    nameLabel.textAlignment = .right
    
    valueLabel = UILabel()
    valueLabel.font = .preferredFont(forTextStyle: .headline)
    valueLabel.numberOfLines = 0
    valueLabel.textAlignment = .right
    
    let stackView = UIStackView(arrangedSubviews: [nameLabel, valueLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 20
    stackView.distribution = .fillEqually
    stackView.alignment = .firstBaseline
//    stackView.axis = .vertical
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  func update(name: String, value: String) {
    nameLabel.text = name
    valueLabel.text = value
  }
}
