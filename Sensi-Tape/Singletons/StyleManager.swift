//
//  StyleManager.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/11/23.
//

import Foundation
import UIKit

final class StyleManager {
    static let shared = StyleManager()
    
    public func styleViews (_ views: [UIView]) {
        for view: UIView in views {
            view.layer.cornerRadius = 10.0
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    public func styleTableView (_ tableView: UITableView) {
        tableView.backgroundColor = .quaternarySystemFill
    }
}
