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
    private let graphColors : [UIColor] = [.blue, .green, .red, .white]
    
    static public func styleViews (_ views: [UIView]) {
        for view: UIView in views {
            view.layer.cornerRadius = 10.0
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    static public func styleTableView (_ tableView: UITableView) {
        tableView.backgroundColor = .quaternarySystemFill
    }
    
    public func getGraphColor (_ index: Int) -> UIColor {
        return self.graphColors[index]
    }
    
    static public func getSubtitleFont() -> UIFont {
        return UIFont(descriptor: UIFontDescriptor(name: "Inconsolata", size: 14), size: 14)
    }
    
    static public func datePipe(_ date: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "hh:mm a MM/dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
    }
    
    static public func timePipe(_ time: Int) -> String {
        return "\(time/3600) hrs, \(time%3600/60) mins"
    }
}
