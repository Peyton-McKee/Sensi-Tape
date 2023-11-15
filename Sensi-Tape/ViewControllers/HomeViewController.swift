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
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultKey.userId.rawValue) else {
            self.handle(error: UserError.notSignedInError)
            return
        }
        APIHandler.shared.queryData(route: Route.userById(userId: userId), completion: {
            result in
            do {
                let currentUser: AuthenticatedUser = try result.get()
                Model.shared.setCurrentUser(currentUser)
                DispatchQueue.main.async {
                    self.introLabel.text = "Hey \(currentUser.firstName)"
                }
            } catch {
                DispatchQueue.main.async{
                    self.handle(error: error)
                }
            }
        })
    }

}
