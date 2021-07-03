//  Created by Dominik Hauser on 01/07/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class FormulaCollectionViewListCell: UICollectionViewListCell {
  let imageView: UIImageView
  let nameLabel: UILabel
  let toolsIndicatorImageView: UIImageView
  private var formula: Formula? = nil
  private var imageHeightConstraint: NSLayoutConstraint?
  private var imageWidthConstraint: NSLayoutConstraint?
  private var nameTopConstraint: NSLayoutConstraint?
  private var imageTopConstraint: NSLayoutConstraint?
  private var imageBottomConstraint: NSLayoutConstraint?

  override init(frame: CGRect) {

    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = .preferredFont(forTextStyle: .body)
    nameLabel.adjustsFontForContentSizeCategory = true
    nameLabel.numberOfLines = 3

    imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false

    toolsIndicatorImageView = UIImageView(image: UIImage(systemName: "wrench.and.screwdriver"))
    toolsIndicatorImageView.translatesAutoresizingMaskIntoConstraints = false
    toolsIndicatorImageView.isHidden = true

    super.init(frame: frame)

    contentView.addSubview(nameLabel)
    contentView.addSubview(imageView)
    contentView.insertSubview(toolsIndicatorImageView, belowSubview: imageView)

    imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 20)
    imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 20)

    nameTopConstraint = nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
    imageTopConstraint = imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6)
    imageBottomConstraint = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)

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
      imageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      imageBottomConstraint,
      imageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
      imageHeightConstraint,
      imageWidthConstraint,

      toolsIndicatorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      toolsIndicatorImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5),

      toolsIndicatorImageView.widthAnchor.constraint(equalToConstant: 16),
      toolsIndicatorImageView.heightAnchor.constraint(equalTo: toolsIndicatorImageView.widthAnchor),
    ])
  }

  required init?(coder: NSCoder) { fatalError() }

  func update(with item: Formula) {

    guard formula != item else { return }
    formula = item
    setNeedsUpdateConfiguration()
  }

  override var configurationState: UICellConfigurationState {
    var state = super.configurationState
    state.formula = self.formula
    return state
  }

  override func updateConfiguration(using state: UICellConfigurationState) {

    let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)

    if let title = state.formula?.title {
      nameLabel.text = title.localized
      nameLabel.textColor = valueConfiguration.textProperties.resolvedColor()
    }

    guard let imageName = state.formula?.imageName, let image = UIImage(named: imageName) else {
      print("image missing: \(String(describing: state.formula?.imageName))")
      return
    }
    imageView.image = image
    imageView.tintColor = valueConfiguration.textProperties.resolvedColor()

    if let formula = state.formula {
      let solvers = formula.details?.flatMap({ $0.detailItems }).filter({ detailItem in
        return false == detailItem.inputs?.isEmpty
      })
      if false == solvers?.isEmpty {
        toolsIndicatorImageView.isHidden = false
      } else {
        toolsIndicatorImageView.isHidden = true
      }
    }

    imageWidthConstraint?.isActive = false

    let size = image.size
    imageWidthConstraint = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: size.width/size.height)
    imageWidthConstraint?.isActive = true

    nameTopConstraint?.constant = valueConfiguration.textToSecondaryTextVerticalPadding * 2
    imageTopConstraint?.constant = valueConfiguration.textToSecondaryTextVerticalPadding * 3
    imageBottomConstraint?.constant = -valueConfiguration.textToSecondaryTextVerticalPadding * 3

    traitCollectionDidChange(nil)
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

    let fontMetrics = UIFontMetrics(forTextStyle: .body)

    imageView.update(heightConstraint: imageHeightConstraint, fontMetrics: fontMetrics)

    tintColor = UIColor.label
  }
}

fileprivate extension UIConfigurationStateCustomKey {
  static let formula = UIConfigurationStateCustomKey("de.dasdom.item")
}

fileprivate extension UICellConfigurationState {
  var formula: Formula? {
    set { self[.formula] = newValue }
    get { self[.formula] as? Formula }
  }
}
