//  Created by Dylan  on 3/11/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import UIKit

///
extension UICollectionViewCell {
    static var cellReuseIdentifier: String {
        return String(describing: self)
    }
}

///
extension UICollectionReusableView {
    static var viewReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    //MARK: - Registering
    /// Register a CollectionView cell with generic type
    func registerCell<T: UICollectionViewCell>(cellClass: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.cellReuseIdentifier)
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(viewClass: T.Type) {
        register(T.self, forSupplementaryViewOfKind: T.viewReuseIdentifier, withReuseIdentifier: T.viewReuseIdentifier)
    }
    
    
    //MARK: Dequeueing Views
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cellReuseIdentifier = T.cellReuseIdentifier
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? T
            else {
                assertionFailure("Unable to dequeue a cell for \(cellReuseIdentifier)")
                return T()
        }
        return cell
    }
    
    
    func dequeueReusableView<T: UICollectionReusableView>(indexPath: IndexPath) -> T {
        let viewReuseIdentifier = T.viewReuseIdentifier
        
        guard let view = dequeueReusableSupplementaryView(ofKind: viewReuseIdentifier, withReuseIdentifier: viewReuseIdentifier, for: indexPath) as? T
            else {
                assertionFailure("Unable to dequeue a supplementary view for \(viewReuseIdentifier)")
                return T()
        }
        return view
    }
    
    
}
