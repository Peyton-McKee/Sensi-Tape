//
//  MainTabBarViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let gradientlayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradientBackground(colorOne: .orange, colorTwo: UIColor(rgb: 0xFFCC99))
    
        // Do any additional setup after loading the view.
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor)  {
        self.gradientlayer.frame = CGRect(x: self.tabBar.bounds.minX, y: self.tabBar.bounds.minY, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height + 50)
        self.gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        self.gradientlayer.locations = [0, 1]
        self.gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        self.gradientlayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.tabBar.layer.insertSublayer(self.gradientlayer, at: 0)
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
