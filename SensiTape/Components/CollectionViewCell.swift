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
        imageView.tintColor = .black
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = .gray
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
    }
}
