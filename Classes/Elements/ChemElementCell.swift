//  Created by dasdom on 25.08.19.
//  
//

import UIKit

class ChemElementCell: DDHBaseTableViewCell<ChemElement> {

  let titleLabel: UILabel
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    titleLabel = UILabel()
    
    let titleAbbreviationStackView = UIStackView(arrangedSubviews: [titleLabel])
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .white
    
    let stackView = UIStackView(arrangedSubviews: [titleAbbreviationStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func update(with item: ChemElement) {
    titleLabel.text = item.title
  }
}
