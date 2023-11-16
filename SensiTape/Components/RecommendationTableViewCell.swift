//
//  RecommendationTableViewCell.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
    private lazy var label : UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: self.frame.width, height: 30))
        label.textColor = .white
        return label
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(self.label)
        self.backgroundColor = .clear
        // Configure the view for the selected state
    }
    
    public func setLabelText (_ text: String?, _ color: UIColor = .white) {
        self.label.text = text
        self.label.textColor = color
    }
}
