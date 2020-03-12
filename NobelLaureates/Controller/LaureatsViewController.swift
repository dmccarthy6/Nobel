//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.

import UIKit

/* Test Lat: 38.723440 Long: -121.084080 */
final class LaureatesViewController: UIViewController, DecodeLaureat {
    //MARK: - Properties
    typealias Element = Laureate
    typealias DiffableSnapShot = NSDiffableDataSourceSnapshot<Section, Element>
    typealias DifDataSource = UICollectionViewDiffableDataSource<Section, Element>
    var userEnteredData: Laureate?
    var dataSource: [Laureate] = []
    
    enum Section: CaseIterable {
        case closestEvents
        
        var title: String {
            switch self {
            case .closestEvents:     return "Closest Events"
            }
        }
    }
    
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, environment -> NSCollectionLayoutSection? in
            
            let inset = CGFloat(16)
            let deviceIsCompact = environment.container.effectiveContentSize.width < 450
            let columns = deviceIsCompact ? 2 : 3
            
            let section = NSCollectionLayoutSection
                .grid(itemHeight: .absolute(200), itemSpacing: inset, numberOfColumns: columns)
                .withSectionHeader(estimatedHeight: 50, kind: HeaderView.viewReuseIdentifier)
                .withContentInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            return section
        }
        return layout
    }()
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        collectionView.registerCell(cellClass: NobelCell.self)
        collectionView.registerSupplementaryView(viewClass: HeaderView.self)
        return collectionView
        }()
    private lazy var diffableDataSource: DifDataSource = {
        /// set up cell
        let diffableDataSource = DifDataSource(collectionView: collectionView) { [weak self]
            (collectionView, indexPath, element) -> UICollectionViewCell? in
            
            let cell: NobelCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(name: element.firstname, surname: element.surname, category: element.category, motivation: element.motivation)
            return cell
        }
        /// Set Up Header
        diffableDataSource.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath -> UICollectionReusableView? in
            let section = diffableDataSource.snapshot().sectionIdentifiers[indexPath.section]
            let header: HeaderView = collectionView.dequeueReusableView(indexPath: indexPath)
            header.configure(with: section.title)
            return header
        }
        return diffableDataSource
    }()
    
    
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        decodeJSONDataAndCreateGraph()
        setupDatasource()
        navigationItem.title = "Nobel Laureate Events"
    }
    
    
    
    //MARK: - Helpers
    private func setupDatasource() {
        let snapshot = buildSnapshot(with: dataSource)
        diffableDataSource.apply(snapshot)
    }
    
    private func buildSnapshot(with dataSource: [Laureate]) -> DiffableSnapShot {
        var snapShot = DiffableSnapShot()
        snapShot.appendSections([.closestEvents])
        
        for section in snapShot.sectionIdentifiers {
            snapShot.appendItems(dataSource, toSection: section)
        }
        return snapShot
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    ///Calls 'decodeJSONFromFile' method in DecodeLaureat protocol that
    ///
    func decodeJSONDataAndCreateGraph() {
        let laureats = decodeJSONFromFileAndPerformSearch()
        dataSource = laureats
        let graph = CreateGraph()
        if let userLaureate = userEnteredData {
            graph.implementNobelLaureatesGraph(with: userLaureate)
        }
    }
    
}

