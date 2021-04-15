//  Created by dasdom on 14.09.19.
//  
//

import UIKit

class ChemElementDetailViewController: UITableViewController {

  let element: ChemElement
  
  init(element: ChemElement) {
    
    self.element = element
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(ChemElementDetailCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupHeader(for: tableView.bounds.size)
  }
  
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
    setupHeader(for: size)
  }
  
  func setupHeader(for size: CGSize) {
    
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: 0))
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
    let abbreviationLabel = UILabel()
    abbreviationLabel.font = .preferredFont(forTextStyle: .largeTitle)
    abbreviationLabel.textAlignment = .center
    abbreviationLabel.text = element.abbreviation
    
    let ordinalLabel = UILabel()
    ordinalLabel.font = .preferredFont(forTextStyle: .headline)
    ordinalLabel.textAlignment = .center
    ordinalLabel.text = "\(element.ordinal)"
    
    let nameLabel = UILabel()
    nameLabel.font = .preferredFont(forTextStyle: .headline)
    nameLabel.textAlignment = .center
    nameLabel.text = element.name
    
    let stackView = UIStackView(arrangedSubviews: [abbreviationLabel, ordinalLabel, nameLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    
    headerView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
      stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
      stackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
    ])
    
    let widthConstraint = headerView.widthAnchor.constraint(equalToConstant: size.width)
    widthConstraint.isActive = true
    
    let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    
    widthConstraint.isActive = false
    
    headerView.frame = CGRect(x: 0, y: 0, width: size.width, height: height)
    headerView.translatesAutoresizingMaskIntoConstraints = true
    
    tableView.tableHeaderView = headerView
  }
}

// MARK: - UITableViewDataSource
extension ChemElementDetailViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Row.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChemElementDetailCell
    
    guard let row = Row(rawValue: indexPath.row) else {
      return cell
    }
    
    cell.update(name: row.name, value: row.value(element: element))
    
    return cell
  }
}

extension ChemElementDetailViewController {
  enum Row: Int, CaseIterable {
//    case ordinal
    case atomMass
  //  case chemieBool
    case electronConfiguration
    case group
    case period
//    case yPos
  //  case title
    case pauling
    case mostImportantRadioactiveIsotope
    case decayType
    case lifetime
    case phaseNorm
    case crystalStructure
    
    var name: String {
      let name: String
      switch self {
//        case .ordinal:
//          name = "Ordnungszahl"
        case .atomMass:
          name = "Atommasse"
        case .electronConfiguration:
          name = "Elektronenkonfiguration"
        case .group:
          name = "Gruppe"
        case .period:
          name = "Periode"
        case .pauling:
          name = "Pauling-Elektronegativität"
        case .mostImportantRadioactiveIsotope:
          name = "Wichtigstes radioaktives Isotop"
        case .decayType:
          name = "Zerfallsart"
        case .lifetime:
          name = "Lebensdauer"
        case .phaseNorm:
          name = "Phase (Normbedingungen)"
        case .crystalStructure:
          name = "Kristallstruktur"
      }
      return name.localized
    }
    
    func value(element: ChemElement) -> String {
      let value: String
      switch self {
//        case .ordinal:
//          value = "\(element.ordinal)"
        case .atomMass:
          value = "\(element.atomMass)"
        case .electronConfiguration:
          value = element.electronConfiguration
        case .group:
          value = element.group
        case .period:
          value = "\(element.period)"
        case .pauling:
          value = element.pauling
        case .mostImportantRadioactiveIsotope:
          if let isotop = element.mostImportantRadioactiveIsotope {
            value = "\(isotop)"
          } else {
            value = "-"
          }
        case .decayType:
          value = element.decayType
        case .lifetime:
          value = element.lifetime
        case .phaseNorm:
          value = element.phaseNorm
        case .crystalStructure:
          value = element.crystalStructure
      }
      return value.localized
    }
  }
}
