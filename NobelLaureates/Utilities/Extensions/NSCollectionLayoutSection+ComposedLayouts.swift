//  Created by Dylan  on 3/11/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import UIKit

extension NSCollectionLayoutSection {
    
    /// Creating a grid layout within the CollectionView. 
    static func grid(itemHeight: NSCollectionLayoutDimension, itemSpacing: CGFloat, numberOfColumns: Int) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: numberOfColumns)
        group.interItemSpacing = .fixed(itemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = itemSpacing

        return section
    }
    
    /// If using Section  Header
    @discardableResult
       func withSectionHeader(estimatedHeight: CGFloat, kind: String) -> NSCollectionLayoutSection {
           let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
           let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem( layoutSize: headerFooterSize, elementKind: kind, alignment: .top)
           self.boundarySupplementaryItems = [sectionHeader]
           return self
       }
        
    /// Adding content insets for section/cell.
       @discardableResult
       func withContentInsets(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> NSCollectionLayoutSection {
           self.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
           return self
       }
}
