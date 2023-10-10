//
//  LoadingScreen.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/9/23.
//

import Foundation
import UIKit

class LoadingScreen: UIView {
    var activityMonitor: UIActivityIndicatorView
    
    override init(frame: CGRect) {
        self.activityMonitor = UIActivityIndicatorView(frame: frame)
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubview(self.activityMonitor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setDoneLoading(value : Bool) {
        DispatchQueue.main.async {
            self.isHidden = value
        }
    }
}
