//
//  ProfileViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/14/23.
//

import UIKit

class ProfileViewController: UIViewController, ErrorHandler {
    @IBOutlet var HeaderView: HeaderView!
    @IBOutlet var profilePictureImageVIew: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var AgeLabel: UILabel!
    @IBOutlet var ActivityLevelLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let currentUser = try Model.shared.getCurrentUser()
            self.nameLabel.text = currentUser.fullName
        } catch {
            self.handle(error: error)
        }

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
