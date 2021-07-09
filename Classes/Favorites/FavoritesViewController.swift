//  Created by Dominik Hauser on 08/07/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class FavoritesViewController: FormulasViewController {

  private var _sections: [ FormulaSection] = []
  override var sectionsToShow: [FormulaSection] {
    return _sections
  }

  init(formulaStore: FormulaStoreProtocol) {
    super.init(sectionsInSpecialField: [], formulaStore: formulaStore)
  }

  required init?(coder: NSCoder) { fatalError() }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if let sections = formulaStore?.allFavoritesSpecialFieldSections() {
      self._sections = sections
      newSnapshot()
    }
  }
}
