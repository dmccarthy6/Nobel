//  Created by Dylan  on 3/11/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import UIKit

final class NobelCell: UICollectionViewCell {
    //MARK: - Properties
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(for: .body, weight: .semibold)
        label.textColor = .label
        return label
    }()
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(for: .body, weight: .medium)
        label.textColor = .label
        return label
    }()
    private var motivationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(for: .body, weight: .thin)
        label.textColor = .label
        return label
    }()
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutCell()
        setupCardStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Handling card view shadows
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.label.resolvedColor(with: traitCollection).cgColor
        layer.shadowOpacity = traitCollection.userInterfaceStyle == .some(.dark) ? 0 : 0.3
    }
    
    //MARK: - Helper Methods
    func layoutCell() {
        backgroundColor = .red
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(motivationLabel)
        
        let guide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            motivationLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            motivationLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            motivationLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor)
        
        ])
    }
    
    func setupCardStyle() {
        contentView.layer.cornerCurve = .circular
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemBackground
        contentView.layer.masksToBounds = true
        
        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
    
    //MARK: - Interface Methods
    func configure(name: String?, surname: String?, category: String?, motivation: String?) {
        let fullName = "\(name ?? ""), \(surname ?? "")"
        print("NAME: \(name), SURNAME: \(surname), CAT: \(category), motivation: \(motivation)")
        nameLabel.text = fullName
        categoryLabel.text = category
        motivationLabel.text = motivation
    }
}
