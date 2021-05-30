//  Created by Dominik Hauser on 30/05/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class SolverDetailRadOrDegreeInputCell: UITableViewCell {

  let angleTypeSegmentedControl: UISegmentedControl
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    angleTypeSegmentedControl = UISegmentedControl(items: ["Rad", "Deg"])
    angleTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
    angleTypeSegmentedControl.selectedSegmentIndex = 0
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(angleTypeSegmentedControl)
    
    NSLayoutConstraint.activate([
      angleTypeSegmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      angleTypeSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      angleTypeSegmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      angleTypeSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
}
