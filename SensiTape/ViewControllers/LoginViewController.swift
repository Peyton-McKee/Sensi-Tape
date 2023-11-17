//
//  LoginViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/4/23.
//

import UIKit

class LoginViewController: UIViewController, ErrorHandler {
    
    var allUsers: [User] = []
    var selectedUser: User?
    lazy var loadingScreen = LoadingScreen(frame: self.view.frame)
    @IBOutlet var pickerView: UIPickerView!
    
    lazy var pickerViewContainer = PickerViewContainer(PickerViewConfig(label: "Select User", function: self.setUser), self.pickerView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.loadingScreen)
        self.assignAllUsers()
        self.pickerViewContainer.setOptions(options: [])
        self.view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    func assignAllUsers () -> Void {
        APIHandler.shared.queryData(route: Route.allUsers(), completion: { result in
            do {
                self.allUsers = try result.get()
                self.selectedUser = self.allUsers.first
                DispatchQueue.main.async {
                    self.pickerViewContainer.setOptions(options: self.allUsers.map({PickerViewOptionConfig(label: $0.fullName, value: $0)}))
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
            self.loadingScreen.setDoneLoading(value: true)
        })
    }
    
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        guard let selectedUser = selectedUser else {
            self.handle(error: UserError.noUserSelectedError)
            return
        }
        UserDefaults.standard.setValue(selectedUser.id, forKey: UserDefaultKey.userId.rawValue)
        let storyboard = UIStoryboard(name: StoryboardId.storyboardId.rawValue, bundle: nil)
        let mainNavigationController = storyboard.instantiateViewController(identifier: StoryboardId.mainNavigationController.rawValue)
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainNavigationController)
        
    }
                                                       
    func setUser(_ user: User) -> Void {
        guard allUsers.count > 0 else {
            return
        }
        self.selectedUser = user
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
