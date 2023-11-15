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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentUser()
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
                Model.shared.setCurrentUser(try result.get())
                print("test")

            } catch {
                DispatchQueue.main.async{
                    self.handle(error: error)
                }
            }
        })
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
