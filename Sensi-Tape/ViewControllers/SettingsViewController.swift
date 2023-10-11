//
//  SettingsViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/9/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
