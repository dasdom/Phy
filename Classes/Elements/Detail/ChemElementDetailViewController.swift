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
}

// MARK: - UITableViewDataSource
extension ChemElementDetailViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Row.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    guard let row = Row(rawValue: indexPath.row) else {
      return cell
    }
    
    cell.textLabel?.text = row.name
    cell.detailTextLabel?.text = row.value(element: element)

    return cell
  }
}

extension ChemElementDetailViewController {
  enum Row: Int, CaseIterable {
    case ordinal
    case atomMass
  //  case chemieBool
  //  case electronConfiguration
  //  case group
  //  case period
  //  case yPos
  //  case title
  //  case pauling
  //  case mostImportantRadioactiveIsotope
  //  case decayType
  //  case lifetime
  //  case phaseNorm
  //  case crystalStructure
    
    var name: String {
      let name: String
      switch self {
        case .ordinal:
          name = "Ordnungszahl"
        case .atomMass:
          name = "Atommasse"
        default:
          name = ""
      }
      return name.localized
    }
    
    func value(element: ChemElement) -> String {
      let value: String
      switch self {
        case .ordinal:
          value = "\(element.ordinal)"
        case .atomMass:
          value = "\(element.atomMass)"
      }
      return value.localized
    }
  }
}
