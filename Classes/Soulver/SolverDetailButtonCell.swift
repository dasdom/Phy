//  Created by dasdom on 12.08.19.
//  
//

import UIKit

class SolverDetailButtonCell: UITableViewCell {
  
  let button: UIButton
  
  static var identifier: String {
    return NSStringFromClass(self)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    button = UIButton(type: .system)
    button.setTitle(NSLocalizedString("Berechnen", comment: ""), for: .normal)
    button.titleLabel?.font = .preferredFont(forTextStyle: .body)
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(button)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: contentView.topAnchor),
      button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {fatalError()}
}
