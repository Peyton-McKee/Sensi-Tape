//
//  ProfileViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/14/23.
//

import UIKit

class ProfileViewController: UIViewController, ErrorHandler {
    @IBOutlet var headerView: HeaderView!
    @IBOutlet var profilePictureImageVIew: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var activityLevelLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let currentUser = try Model.shared.getCurrentUser()
            self.assignValues(currentUser)
        } catch {
            self.handle(error: error)
        }
        

        // Do any additional setup after loading the view.
    }
    
    private func assignValues(_ user: AuthenticatedUser) {
        self.headerView.viewController = self
        self.nameLabel.text = user.fullName
        guard let userSettings = user.userSettings else {
            return
        }
        self.genderLabel.text = userSettings.gender
        self.heightLabel.text = "\(userSettings.height/12)' \(userSettings.height%12)\""
        self.weightLabel.text = "\(userSettings.weight) lbs"
        self.ageLabel.text = "\(userSettings.age)"
        self.activityLevelLabel.text = userSettings.activityLevel
    }
    
    @IBAction func logout(sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.userId.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.compressionValue.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.temperatureValue.rawValue)
        let storyboard = UIStoryboard(name: StoryboardId.storyboardId.rawValue, bundle: nil)
        let logInViewController = storyboard.instantiateViewController(identifier: StoryboardId.logInViewController.rawValue)
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(logInViewController)
    }

}
