//
//  HomeViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/14/23.
//

import UIKit

class HomeViewController: UIViewController, ErrorHandler {
    @IBOutlet var headerView: HeaderView!
    @IBOutlet var visualizationImageView: UIImageView!
    
    @IBOutlet var introLabel: UILabel!
    
    @IBOutlet var summaryContentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentUser()
        self.visualizationImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.visualizationImageView.image = .init(named: "sock")
        // Do any additional setup after loading the view.
    }
    
    private func getCurrentUser() {
        Model.shared.requestUserRefresh(self.handle(error: ), self.successFunction)
    }
    
    private func successFunction(_ user :AuthenticatedUser) {
        self.introLabel.text = "Hey, \(user.firstName)"
    }
}
