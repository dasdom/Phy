//  Created by dasdom on 25.08.19.
//  
//

import UIKit

class ChemElementCell: DDHBaseTableViewCell<ChemElement> {

  private let abbreviationLabel: UILabel
  private let ordinalLabel: UILabel
  private let nameLabel: UILabel
  private let massLabel: UILabel
  private let electronConfigurationLabel: UILabel
  private let detailStackView: UIStackView
  private let stackView: UIStackView
  private let abbreviationStackView: UIStackView
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    abbreviationLabel = UILabel()
    abbreviationLabel.font = .preferredFont(forTextStyle: .title2)
    abbreviationLabel.textAlignment = .center
    abbreviationLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
    ordinalLabel = UILabel()
    ordinalLabel.font = .preferredFont(forTextStyle: .body)
    ordinalLabel.textAlignment = .center
    ordinalLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

    abbreviationStackView = UIStackView(arrangedSubviews: [abbreviationLabel, ordinalLabel])
    abbreviationStackView.axis = .vertical

    nameLabel = UILabel()
    nameLabel.font = .preferredFont(forTextStyle: .headline)

    massLabel = UILabel()
    massLabel.font = .preferredFont(forTextStyle: .body)
    
    electronConfigurationLabel = UILabel()
    electronConfigurationLabel.font = .preferredFont(forTextStyle: .body)
    electronConfigurationLabel.numberOfLines = 0

    detailStackView = UIStackView(arrangedSubviews: [massLabel, electronConfigurationLabel])
    detailStackView.spacing = 5
    
    let infoStackView = UIStackView(arrangedSubviews: [nameLabel, detailStackView])
    infoStackView.axis = .vertical
    
    stackView = UIStackView(arrangedSubviews: [abbreviationStackView, infoStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 20
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .white
    
    
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      
      abbreviationStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
      ])
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func update(with item: ChemElement) {
    abbreviationLabel.text = item.abbreviation
    ordinalLabel.text = "\(item.ordinal)"
    
    nameLabel.text = item.name
    
    massLabel.text = "\(item.atomMass)"
    electronConfigurationLabel.text = item.electronConfiguration
    
    if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
      detailStackView.axis = .vertical
      stackView.axis = .vertical
      abbreviationStackView.alignment = .leading
    } else {
      detailStackView.axis = .horizontal
      stackView.axis = .horizontal
      abbreviationStackView.alignment = .fill
    }
  }
}
