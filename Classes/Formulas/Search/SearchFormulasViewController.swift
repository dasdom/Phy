//  Created by Dominik Hauser on 30/04/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class SearchFormulasViewController: FormulasViewController {

  let allFormulaSections: [FormulaSection]
  let searchBar: UISearchBar
  private var _sections: [ FormulaSection] = []
  override var sectionsToShow: [FormulaSection] {
    return _sections
  }

  init(specialFieldSections: [SpecialFieldSection]) {

    allFormulaSections = specialFieldSections.flatMap({ $0.specialFields }).flatMap({ $0.formulaSections })

    searchBar = UISearchBar(frame: .zero)
    searchBar.translatesAutoresizingMaskIntoConstraints = false

    super.init(sectionsInSpecialField: allFormulaSections)

    searchBar.delegate = self

    view.addSubview(searchBar)

    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      searchBar.heightAnchor.constraint(equalToConstant: 50),
    ])

    collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
  }

  required init?(coder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    searchBar.becomeFirstResponder()

    title = "Suche".localized
  }
}

extension SearchFormulasViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    var sections: [FormulaSection] = []

    for formulaSection in allFormulaSections {
      let lowercaseTitle = formulaSection.title.localized.lowercased()
      if lowercaseTitle.contains(searchText.lowercased()) {
        sections.append(formulaSection)
        continue
      }
      let formulas = formulaSection.formulas.filter { formula -> Bool in
        let lowercaseTitle = formula.title?.localized.lowercased()
        return (lowercaseTitle?.contains(searchText.lowercased()) ?? false)
      }
      if formulas.count > 0 {
        sections.append(FormulaSection(id: formulaSection.id, title: formulaSection.title, formulas: formulas))
      }

    }

    self._sections = sections
    newSnapshot()
  }
}
