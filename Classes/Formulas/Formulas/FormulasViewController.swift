//  Created by dasdom on 05.08.19.
//
//

import UIKit

protocol FormulasViewControllerProtocol: AnyObject {
  func formulaSelected(_ viewController: UIViewController, formula: Formula)
}

class FormulasViewController: UIViewController {

  var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Formula>!
  private let favoritesUUID = UUID()
  private let sectionsInSpecialField: [FormulaSection]
  var sectionsToShow: [FormulaSection] {
    let sections: [FormulaSection]
    if let favoritesSection = formulaStore?.favoritesSection(from: sectionsInSpecialField, favoritesUUID: favoritesUUID) {
      sections = [favoritesSection] + sectionsInSpecialField
    } else {
      sections = sectionsInSpecialField
    }
    return sections
  }
  let formulaStore: FormulaStoreProtocol?
  var delegate: FormulasViewControllerProtocol?

  init(sectionsInSpecialField: [FormulaSection], formulaStore: FormulaStoreProtocol? = nil) {

    self.sectionsInSpecialField = sectionsInSpecialField
    self.formulaStore = formulaStore

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureHierarchy()
    configureDataSource()
  }

  private func configureHierarchy() {
    collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: createLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = UIColor.systemBackground
    collectionView.delegate = self

    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }

  private func createLayout() -> UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { section, layoutEnvironment in
      var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
      config.headerMode = .supplementary

      let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)

      let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))

      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: "header", alignment: .top)

      sectionHeader.pinToVisibleBounds = true
      sectionHeader.zIndex = Int.max

      section.boundarySupplementaryItems = [sectionHeader]

      return section
    }
  }

  private func configureDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<FormulaCollectionViewListCell, Formula> { cell, indexPath, formula in
      cell.update(with: formula)
      if nil == formula.details {
        cell.accessories = []
      } else {
        cell.accessories = [.disclosureIndicator()]
      }
    }

    dataSource = UICollectionViewDiffableDataSource<Section, Formula>(collectionView: collectionView, cellProvider: { collectionView, indexPath, formula in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: formula)
    })

    let headerRegistration = UICollectionView.SupplementaryRegistration<FormulaHeaderView>(elementKind: "header") { headerView, elementKind, indexPath in
      headerView.label.text = self.sectionsToShow[indexPath.section].title.localized
    }

    dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
      return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    newSnapshot()
  }

  func newSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Formula>()
    for formulaSection in sectionsToShow {
      let section = Section(id: formulaSection.id, title: formulaSection.title)
//      print("\(title)")
      snapshot.appendSections([section])
      snapshot.appendItems(formulaSection.formulas, toSection: section)
    }
    dataSource.apply(snapshot, animatingDifferences: true)

    for indexPath in collectionView.indexPathsForSelectedItems ?? [] {
      collectionView.deselectItem(at: indexPath, animated: true)
    }
  }
}

extension FormulasViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let formula = sectionsToShow[indexPath.section].formulas[indexPath.row]
    delegate?.formulaSelected(self, formula: formula)
  }
}

private struct Section: Hashable {
  let id: UUID
  let title: String

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
