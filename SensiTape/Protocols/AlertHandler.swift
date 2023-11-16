//
//  AlertHandler.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation
import UIKit

protocol AlertHandler {
    func alert(_ message: String)
}

extension AlertHandler where Self: UIViewController {
    func alert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
