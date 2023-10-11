//
//  TableViewHeaderView.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/11/23.
//

import UIKit

class TableViewHeaderView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear

        self.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitleLabelText(_ text: String?) {
        self.titleLabel.text = text
    }
    
}
