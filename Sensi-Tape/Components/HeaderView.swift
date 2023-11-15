//
//  HeaderView.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/14/23.
//

import UIKit

class HeaderView: UIView {
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "images/logo")
        return imageView
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(self.displaySearchScreen), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 60))
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        [self.logoImageView, self.searchButton].forEach({
            stackView.addArrangedSubview($0)
        })
        return stackView
    }()
    
    @objc func displaySearchScreen() {
        print("search button pressed")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(self.horizontalStackView)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
