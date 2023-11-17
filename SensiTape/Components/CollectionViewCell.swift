//
//  CollectionViewCell.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = StyleManager.shared.getSubtitleFont()
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "play.rectangle")
        imageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        imageView.tintColor = .label
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    lazy var vstack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.layer.cornerRadius = 10
        
        [self.imageView, self.titleLabel].forEach({
            stackView.addArrangedSubview($0)
        })
        return stackView
    }()
    
    func configure(_ config: CollectionViewCellConfig) {
        self.titleLabel.text = config.title
        self.contentView.layer.cornerRadius = 15
        self.contentView.addSubview(self.vstack)
        self.vstack.frame = self.contentView.frame
        self.layer.cornerRadius = 25
        
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 8.0

        // The color of the drop shadow
        self.layer.shadowColor = UIColor.label.cgColor

        // How transparent the drop shadow is
        self.layer.shadowOpacity = 0.10

        // How far the shadow is offset from the UICollectionViewCell’s frame
        self.layer.shadowOffset = CGSize(width: 0, height: 5)

        // Add the shadow layer to the cell's layer
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 25).cgPath

        
//        // Add outline
//        self.layer.borderColor = UIColor.label.cgColor
//        self.layer.borderWidth = 1
    }
}
