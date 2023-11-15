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

    func configure(_ config: CollectionViewCellConfig) {
        self.titleLabel.text = config.title
        self.titleLabel.frame = self.frame
        self.titleLabel.backgroundColor = .orange
        self.backgroundColor = .black
        self.contentView.addSubview(self.titleLabel)
    }
}
