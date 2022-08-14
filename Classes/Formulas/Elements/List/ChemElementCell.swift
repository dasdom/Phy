//  Created by dasdom on 25.08.19.
//  
//

import UIKit
import CommonExtensions


class ChemElementCell: DDHBaseTableViewCell<ChemElement> {

  let abbreviationLabel: UILabel
  let ordinalLabel: UILabel
  let nameLabel: UILabel
  let massLabel: UILabel
  let electronConfigurationLabel: UILabel
  private let detailStackView: UIStackView
  private let stackView: UIStackView
  private let abbreviationStackView: UIStackView
  private let coloredSquareView: UIView
  private var coloredViewLeadingConstraint: NSLayoutConstraint?
  private var coloredViewTrailingConstraint: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    abbreviationLabel = UILabel()
    abbreviationLabel.font = .preferredFont(forTextStyle: .title2)
    abbreviationLabel.textAlignment = .center
    abbreviationLabel.textColor = .white
    abbreviationLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    abbreviationLabel.setContentCompressionResistancePriority(.required, for: .vertical)

    ordinalLabel = UILabel()
    ordinalLabel.font = .preferredFont(forTextStyle: .body)
    ordinalLabel.textAlignment = .center
    ordinalLabel.textColor = .white
    ordinalLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    ordinalLabel.setContentCompressionResistancePriority(.required, for: .vertical)

    abbreviationStackView = UIStackView(arrangedSubviews: [abbreviationLabel, ordinalLabel])
    abbreviationStackView.translatesAutoresizingMaskIntoConstraints = false
    abbreviationStackView.axis = .vertical

    coloredSquareView = UIView()
    coloredSquareView.translatesAutoresizingMaskIntoConstraints = false
    coloredSquareView.backgroundColor = .red
    coloredSquareView.addSubview(abbreviationStackView)
    coloredSquareView.layer.cornerCurve = .continuous
    coloredSquareView.layer.cornerRadius = 10

    let hostView = UIView()
    hostView.addSubview(coloredSquareView)

    nameLabel = UILabel()
    nameLabel.font = .preferredFont(forTextStyle: .headline)

    massLabel = UILabel()
    massLabel.font = .preferredFont(forTextStyle: .body)
    
    electronConfigurationLabel = UILabel()
    electronConfigurationLabel.font = .preferredFont(forTextStyle: .body)
    electronConfigurationLabel.numberOfLines = 0
    electronConfigurationLabel.setContentHuggingPriority(.required, for: .horizontal)

    detailStackView = UIStackView(arrangedSubviews: [massLabel, electronConfigurationLabel])
    detailStackView.spacing = 5
    
    let infoStackView = UIStackView(arrangedSubviews: [nameLabel, detailStackView])
    infoStackView.axis = .vertical

    stackView = UIStackView(arrangedSubviews: [hostView, infoStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 20

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(stackView)

    let coloredViewLeadingConstraint = coloredSquareView.leadingAnchor.constraint(equalTo: hostView.leadingAnchor)
    let coloredViewTrailingConstraint = coloredSquareView.trailingAnchor.constraint(equalTo: hostView.trailingAnchor)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

      abbreviationStackView.topAnchor.constraint(equalTo: coloredSquareView.topAnchor, constant: 8),
      abbreviationStackView.leadingAnchor.constraint(equalTo: coloredSquareView.leadingAnchor, constant: 8),
      abbreviationStackView.bottomAnchor.constraint(equalTo: coloredSquareView.bottomAnchor, constant: -8),
      abbreviationStackView.trailingAnchor.constraint(equalTo: coloredSquareView.trailingAnchor, constant: -8),

      coloredSquareView.topAnchor.constraint(equalTo: hostView.topAnchor),
      coloredSquareView.bottomAnchor.constraint(equalTo: hostView.bottomAnchor) ,
//      coloredSquareView.centerXAnchor.constraint(equalTo: hostView.centerXAnchor),

      coloredViewLeadingConstraint,
      coloredViewTrailingConstraint,

      abbreviationStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
      abbreviationStackView.heightAnchor.constraint(equalTo: abbreviationStackView.widthAnchor),
      ])

    self.coloredViewLeadingConstraint = coloredViewLeadingConstraint
    self.coloredViewTrailingConstraint = coloredViewTrailingConstraint
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func update(with item: ChemElement) {
    abbreviationLabel.text = item.abbreviation
    ordinalLabel.text = "\(item.ordinal)"
    
    nameLabel.text = item.name.localized
    
    massLabel.text = "\(item.atomMass)"
    electronConfigurationLabel.text = item.electronConfiguration

    let colorFloat = item.atomMass/Double(kMaxMass)
    let cellColor = UIColor(hue: colorFloat, saturation: 0.8, brightness: 0.7, alpha: 1)
    coloredSquareView.backgroundColor = cellColor

    if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
      detailStackView.axis = .vertical
      stackView.axis = .vertical
//      abbreviationStackView.alignment = .leading
//      coloredViewLeadingConstraint?.isActive = false
      coloredViewTrailingConstraint?.isActive = false
    } else {
      detailStackView.axis = .horizontal
      stackView.axis = .horizontal
//      abbreviationStackView.alignment = .fill
//      coloredViewLeadingConstraint?.isActive = true
      coloredViewTrailingConstraint?.isActive = true
    }
  }
}
